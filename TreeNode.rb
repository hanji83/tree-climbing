class TreeNode
  attr_accessor :parent
  attr_accessor :children
  attr_accessor :value

  def initialize(value)
    @parent = nil
    @value = value
    @children = []
  end # init

  def remove_child(child_node)
    @children.delete(child_node)
    child_node.parent = nil
  end # remove_child

  #!/usr/bin/env ruby

  def add_child(child_node)
    if !child_node.parent.nil?
      child_node.parent.remove_child(child_node)
    end

    child_node.parent = self
    @children << child_node
  end # add_child


  def dfs(value)
    p "Checking #{self.value}"
     return self if self.value == value

     result_node = nil

     @children.each do |child|
       result_node = child.dfs(value)
       return result_node if !result_node.nil? && result_node.value == value
     end

     result_node
  end # dfs

  def bfs(value)
    queue = []
    queue.unshift(self)

    while !queue.empty?
      current = queue.pop
      p "Checking #{current.value}"
      if current.value == value
        return current
      else
        current.children.each do |child|
          queue.unshift(child)
        end #each
      end #if
    end #while

    return nil

  end # bfs


end # TreeNode

if $PROGRAM_NAME == __FILE__
  root = TreeNode.new(5)
  child1 = TreeNode.new(4)
  child2 = TreeNode.new(7)
  child3 = TreeNode.new(3)
  child4 = TreeNode.new(4)

  root.add_child(child1)
  root.add_child(child2)

  child1.add_child(child3)
  child1.add_child(child4)

  p root.dfs(3)
end
