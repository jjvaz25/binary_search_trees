class Node
  include Comparable
  attr_accessor :value, :left_child, :right_child, :parent

  def initialize(value)
    @value = value
    @left_child = nil
    @right_child = nil
    @parent = nil
  end
end



def build_tree(array)
  array = array.uniq
  root = Node.new(array.shift)
  while array.size != 0
    current_node = Node.new(array.shift)
    add_node(root, current_node)
  end
  root
end

def add_node(root, new_node)
  if root.value > new_node.value #if the root is bigger than new_node, new_node is the left_child
    if root.left_child == nil #if the root doesn't have a left child, make new_node the child
      root.left_child = new_node
      new_node.parent = root
    else #if the root already has a left child, we need to recursively do the add_node
      add_node(root.left_child, new_node)
    end
  else #root < new_node: root is less than new_node, so new_node is the right_child
    if root.right_child == nil #if the root doesn't have a right child, make new_node the child
      root.right_child = new_node
      new_node.parent = root
    else #if the root already has a right child, we need to recursively do the add_node
      add_node(root.right_child, new_node)
    end
  end
end

p build_tree([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])