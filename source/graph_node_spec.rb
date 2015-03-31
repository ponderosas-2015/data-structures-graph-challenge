require_relative 'graph_node'

describe GraphNode do
  describe "::new(value)" do
    it "Instantiates a new GraphNode containing value" do
      node = GraphNode.new(1)
      expect(node.value).to eq 1
    end
  end
  describe "#add_edge(other_node)" do
    it "Add an edge between this node and other_node" do
      node1 = GraphNode.new(1)
      node2 = GraphNode.new(2)
      node1.add_edge(node2)
      expect(node1.edges.contains?(node2)).to be true
    end
  end
  describe "#value" do
    it "Return the value of this node" do
      node2 = GraphNode.new(2)
      expect(node2.value).to be 2
    end
  end
  describe "#edges" do
    it "Return a collection of edges to which this node has an outgoing edge" do
      node1 = GraphNode.new(1)
      node2 = GraphNode.new(2)
      node3 = GraphNode.new(3)
      node4 = GraphNode.new(4)
      node1.add_edge(node2)
      node1.add_edge(node3)
      node3.add_edge(node4)
      expect(node1.edges.contains?(node2)).to be true
      expect(node1.edges.contains?(node3)).to be true
      expect(node1.edges.contains?(node4)).to be false
    end
  end
  describe "#exists? {|node| }" do
    it "Return true if the block passes for any of the edges 'downstream' from this one by following graph edges." do
      node1 = GraphNode.new(1)
      node2 = GraphNode.new(2)
      node3 = GraphNode.new(3)
      node4 = GraphNode.new(4)
      node5 = GraphNode.new(5)
      node1.add_edge(node2)
      node2.add_edge(node3)
      node3.add_edge(node4)
      expect(node1.exists? { |node| node.value === 1 } ).to be true
      expect(node1.exists? { |node| node.value === 2 } ).to be true
      expect(node1.exists? { |node| node.value === 3 } ).to be true
      expect(node1.exists? { |node| node.value === 4 } ).to be true
      expect(node1.exists? { |node| node.value === 5 } ).to be false
    end
  end
end
