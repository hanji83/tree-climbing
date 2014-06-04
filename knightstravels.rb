#!/usr/bin/env ruby

require_relative './TreeNode.rb'
require 'set'

class KnightPathFinder
  attr_reader :move_tree

  def initialize(starting_position)
    @starting_position = starting_position
    @end_position = nil
    @move_tree = build_move_tree
  end #initialize

  def build_move_tree
    root = TreeNode.new(@starting_position)

    visited_positions = Set.new([root.value])

    queue = [root]
    while !queue.empty?
      current_node = queue.pop

      new_move_positions(current_node.value).each do |position|
        if !visited_positions.include?(position)
          visited_positions << position

          new_node = TreeNode.new(position)
          current_node.add_child(new_node)

          queue.unshift new_node
        end # if
      end # each
    end #while

    root
  end #build_move_tree

  def new_move_positions(position)
    deltas = [1,-1].product([2,-2])
    deltas += deltas.map(&:reverse)

    new_positions = []

    deltas.each do |d_row, d_col|
      new_positions << [position.first + d_row, position.last + d_col]
    end

    new_positions.select do |row, col|
      row.between?(0, 7) && col.between?(0, 7)
    end # each
  end # new_move_positions

  def find_path(target_pos)
    target_node = @move_tree.bfs(target_pos)

    path = [target_pos]
    if target_node.parent.nil? # in case the target is the same as the starting
      return path
    end

    parent = target_node.parent
    path << parent.value

    while parent.parent != nil
      parent = parent.parent
      path << parent.value
    end # while

    path.reverse
  end # find_path

end #KnightPathFinder

if $PROGRAM_NAME == __FILE__

  path = KnightPathFinder.new([0,0])
  p path.find_path([6,2])

end