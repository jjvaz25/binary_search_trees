
class Node
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
      puts "\n\nROOT: #{@root.value}"
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

  def find(value, root = @root)
    node_to_find = Node.new(value)
    return nil if root == nil
    if node_to_find.value == root.value
      return root
    elsif node_to_find.value < root.value #search the left children
      root = root.left_child
      find(value, root)
    else #if node_to_find.value > root.value -- search the right children
      root = root.right_child
      find(value, root)
    end
  end

  def insert(value, root = @root)
    p node_to_insert = Node.new(value)
    add_node(@root, node_to_insert)
    # if root == nil #if the tree is empty insert this node as the root
    #   p "the root is nil"
    #   p root = node_to_insert
    # elsif node_to_insert.value < root.value #look to left children
    #   puts "the desired inserted value #{node_to_insert.value} is less than root value"
    #   new_root = root.left_child
    #   insert(value, new_root)
    # else #node_to_insert.value > root.valye look to right children
    #   root = root.right_child
    #   insert(value, root)
    # end
  end

end #end class

#unique_array = [1, 7, 4, 23, 8, 9, 3, 5, 67, 6345, 324]

tree = Tree.new([1, 7, 4, 23, 8, 9, 4, 3, 5, 7, 9, 67, 6345, 324])
p tree.build_tree
puts "______________________"
tree.to_s
puts ""
#print "searching for value 200 (expect nil): " 
#p tree.find(200) #correct return
#p tree.find(1) #correct return
#p tree.find(3) #correct return
#p tree.insert(10, nil) #correct return
tree.insert(0) #correct return, left child of root/1
tree.insert(20) #correct return, right child of 9
tree.to_s
puts "\n\n_______AFTER INSERTS______________\n\n"

