require "~/Desktop/data-structures-set-challenge/source/set"

class GraphNode
  attr_reader :value, :edges

  def initialize(value)
    @value = value
    @edges = MySet.new
  end

  def add_edge(other_node)
    @edges.add(other_node)
  end

  def each(visited = MySet.new, &bloc)
    bloc.call(self)
    visited.add(self)
    self.edges.each do |node|
      if !visited.contains?(node)
        node.each(visited, &bloc)
      end
    end
  end

  def exists?(&bloc)
    self.each do |node|
      return true if bloc.call(node)
    end
    false
  end
end

