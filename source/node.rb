require_relative 'set'

class Node
  attr_reader :value

  def initialize(value)
    @value = value
    @edges = MySet.new
  end

  def add_edge(node)
    @edges.add(node)
  end

  def nodes
    @edges
  end

  def exists?(evaluated_nodes = MySet.new, &block)
    nodes.iterate do |node|
      break if evaluated_nodes.contains?(node)
      evaluated_nodes.add(node)
      return true if yield node.value
      return true if node.exists?(evaluated_nodes, &block)
    end
    return false
  end
end
