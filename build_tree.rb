
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


class Tree 
  attr_accessor :array, :root

  def initialize (array)
    @array = array.uniq
    @root = nil
  end

  def to_s(current = @root, indent = "   ")
    if current == @root
      puts "ROOT: #{@root.value}"
    end
    indent += "  "
    if current.left_child != nil
      puts "#{indent}L: #{current.left_child.value}"
      to_s(current.left_child, indent)
    end
    if current.right_child != nil
      puts "#{indent}R: #{current.right_child.value}"
      to_s(current.right_child, indent)
    end
  end

  def build_tree
    array = @array
    @root = Node.new(array.shift)
    while array.size != 0
      current_node = Node.new(array.shift)
      add_node(@root, current_node)
    end
    @root
  end
  
  def add_node(root, new_node)
    if root.value > new_node.value 
      if root.left_child == nil 
        root.left_child = new_node
        new_node.parent = root
      else 
        add_node(root.left_child, new_node)
      end
    else 
      if root.right_child == nil 
        root.right_child = new_node
        new_node.parent = root
      else 
        add_node(root.right_child, new_node)
      end
    end
  end
end

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
tree.build_tree
tree.to_s

