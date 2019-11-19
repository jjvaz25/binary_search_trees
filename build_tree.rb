class Node
  include Comparable
  attr_accessor :value, :left_child, :right_child

  def <=>(other)
    value <=> other.value
  end

  def initialize(value)
    @value = value
    @left_child = nil
    @right_child = nil
  end
end

nodeA = Node.new(10)
nodeB = Node.new(15)
nodeC = Node.new(2)
nodeD = Node.new(10)

p nodeA < nodeB #return true
p nodeB < nodeA #return false
p nodeA > nodeC #return true
p nodeD.between?(nodeA, nodeB) #return true
p nodeD > nodeB


# def build_tree
#   root = 
# end