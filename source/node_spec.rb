require_relative 'node'
require_relative 'set'

describe Node do
  let(:value) {"hello"}
  let(:value2) {"there"}
  let(:node) {Node.new(value)}
  let(:node2) {Node.new(value2)}

  describe '::new(value)' do
    it 'Instantiate a new Node containing value' do
      expect(Node.new(value)).to be_an_instance_of Node
    end
  end

  describe '#add_edge(other_node)' do
    it 'Add an edge between this node and other_node' do
      node.add_edge(node2)
      expect(node.nodes.contains?(node2)).to be true
    end
    it 'Doesn\'t add edge if other_node is itself' do
      node.add_edge(node)
      expect(node.nodes.contains?(node)).to be false
    end
  end

  describe '#value' do
    it 'Return the value of this node' do
      expect(node.value).to eq value
    end
  end

  describe '#nodes' do
    it 'Return a collection of nodes to which this node has an outgoing edge' do
      node.add_edge(node2)
      expect(node.nodes).to be_an_instance_of MySet
      expect(node.nodes.contains?(node2)).to be true
      expect(node2.nodes.contains?(node)).to be false
    end
  end

  describe '#exists? {|node| }' do
    it 'Return true if the block passes for any of the nodes "downstream" from this one by following graph edges.' do
      node.add_edge(node2)
      expect{ |b| node.exists?(&b) }.to yield_successive_args(value2)
    end
    it 'Works for a cyclic relation?' do
      node.add_edge(node2)
      node2.add_edge(node)
      expect( node.exists? { |val| val == value } ).to be true
    end
    it 'Terminates if condition not met in cyclic relation?' do
      node.add_edge(node2)
      node2.add_edge(node)
      expect( node.exists? { |val| val == "dude" } ).to be false
    end
  end

end
