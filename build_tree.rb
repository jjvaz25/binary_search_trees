puts "\n\nTree initialized \n\n"
class Node
  include Comparable
  attr_accessor :data, :left, :right, :parent

  def initialize(data)
    @data = data
    @left = left
    @right = right
  end

  def <=>(other)
    data <=> other.data
  end

  def leaf?
    left.nil? && right.nil?
  end

  def single_parent?
    left.nil? != right.nil?
  end

end #class end

class Tree
  attr_reader :root

  def initialize(array)
    array = Array(array)
    array.sort!
    array.uniq! #[1, 3, 4, 5, 7, 8, 9, 23, 67, 324, 6345]
    @root = build_tree(array)
  end

  def build_tree(array)
    return nil if array.empty?
    root_index = (array.size - 1) / 2
    root_node = Node.new(array[root_index])
    root_node.left = build_tree(array[0...root_index])
    root_node.right = build_tree(array[(root_index + 1)..-1])
    root_node
  end

  def insert(value, node = root)
    #return node = Node.new(value) if node.nil?
    if value < node.data
      if node.left.nil?
        node.left = Node.new(value)
      else
        insert(value, node.left)
      end
    else
      if node.right.nil?
        node.right = Node.new(value)
      else
        insert(value, node.right)
      end
    end
  end

  def delete(value, node = root)
    return node if node.nil?

    if value < node.data
      node.left = delete(value, node.left)
    elsif value > node.data
      node.right = delete(value, node.right)
    else
      if node.leaf?
        return nil
      elsif node.single_parent?
        return node.left || node.right
      end
      temp = min_value_node(node.right)
      node.data = temp.data
      node.right = delete(temp.data, node.right)
    end
    node
  end

  def min_value_node(node = root)
    current = node
    until current.left.nil?
      current = current.left
    end
    current
  end

  def find(value, node = root)
    return nil if node.nil?
    return node if node.data == value
    if value < node.data
      find(value, node.left)
    else
      find(value, node.right)
    end
  end

  def levelorder(node = root) #prints data in BFS
    queue = []
    queue.push(node)
    while !queue.empty?
      current = queue.shift
      yield(current) 
      if !current.left.nil?
        queue.push(current.left)
      end
      if !current.right.nil?
        queue.push(current.right)
      end 
    end
  end

  def preorder(node = root, result = [], &block)
    return if node.nil?
    block.call(node)
    preorder(node.left, &block)
    preorder(node.right, &block)
  end

  def inorder(node = root, result = [], &block) #visits left subtree, root, then right subtree
    return if node.nil?
    inorder(node.left, &block)
    block.call(node)
    inorder(node.right, &block)
  end

  def postorder(node = root, result = [], &block) #visits leftsubtree, rightsubtree, then root
    return if node.nil?
    inorder(node.left, &block)
    inorder(node.right, &block)
    block.call(node)
  end

  def pretty_print(node = root, prefix="", is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? "│   " : "    "}", false) if node.right
    puts "#{prefix}#{is_left ? "└── " : "┌── "}#{node.data.to_s}"
    pretty_print(node.left, "#{prefix}#{is_left ? "    " : "│   "}", true) if node.left
  end

  def print_dump
    print_proc = Proc.new do |node|
      print "#{node.data} "
    end

    puts "#{levelorder(&print_proc)} - levelorder iterative"
    puts "#{inorder(&print_proc)} - inorder"
    puts "#{preorder(&print_proc)} - preorder"
    puts "#{postorder(&print_proc)} - postorder"
  end

end #class end


tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
# tree.pretty_print
# p tree.find(100000) #CORRECT returns nil
# p tree.find(5) #CORRECT return
# tree.insert(24) #CORRECT return
# puts "\n\n _____________AFTER INSERTS____________\n\n"
# tree.pretty_print
# tree.delete(24)
# puts "\n\n _____________AFTER DELETES____________\n\n"
tree.pretty_print
puts "\n\n\n"
#tree.levelorder{ |node| puts "#{node.data}" }
puts ""
tree.print_dump


