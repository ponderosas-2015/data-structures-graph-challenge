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

  def walk(node, visited, &bloc)
    return true if bloc.call(node)
    visited.add(node)
    node.edges.each do |node|
      if !visited.contains?(node)
        return true if walk(node, visited, &bloc)
      end
    end
    false
  end

  # def each(node, visited, &bloc)
  #   bloc.call(node)
  #   visited.add(node)
  #   node.edges.each do |node|
  #     if !visited.contains?(node)
  #       return each(node, visited, &bloc)
  #     end
  #   end
  # end

  def exists?(&bloc)
    visited = MySet.new
    walk(self, visited, &bloc)
  end

end
