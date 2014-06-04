class TicTacToeNode

  attr_reader :prev_move_pos
  attr_reader :next_player

  def initialize(board, next_player, prev_move_pos = nil)
    @board = board.dup
    @next_player = next_player
    @prev_move_pos = prev_move_pos
  end #initialize

  def children
    next_moves = []
    next_next_player = @next_player == :x ? :o : :x
    @board.rows.each_with_index do |row, r_index|
      row.each_with_index do |position, c_index|
        if position.nil?
          new_board = @board.dup
          new_board[[r_index, c_index]] = @next_player
          new_node = TicTacToeNode.new(new_board,
            next_next_player, [r_index, c_index])
          next_moves << new_node
        end #if
      end #each
    end #each

    next_moves
  end # children

  def winning_node?(player)
    if @board.over? # && !@board.winner.nil?
      return @board.winner == player
    end
    if self.next_player == player
      #p "W2"
      self.children.any? { |node| node.winning_node?(player)}
    elsif self.next_player != player
      #p "W3"
      self.children.all? { |node| node.winning_node?(player)}
    end #if
  end # winning_node

  def losing_node?(player)
    if @board.over? # && !@board.winner.nil?
      return false if @board.winner.nil?
      return @board.winner != player
    elsif self.next_player == player
      self.children.all? { |node| node.losing_node?(player) }
    elsif self.next_player != player
      self.children.any? { |node| node.losing_node?(player) }
    end # if
  end # losing_node

end # TicTacToeNode