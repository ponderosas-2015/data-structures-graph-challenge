require_relative 'node'

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
      expect(node.nodes).to eq [node2]
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
      expect(node.nodes).to eq [node2]
      expect(node2.nodes).to eq []
    end
  end

  describe '#exists? {|node| }' do
    it 'Return true if the block passes for any of the nodes "downstream" from this one by following graph edges.' do
      node.add_edge(node2)
      expect{ |b| node.exists(&b) }.to yield_successive_args(value2)
    end
    it 'Works for a cyclic array?' do
      node.add_edge(node2)
      node2.add_edge(node)
      expect{ |b| node.exists(&b) }.to yield_successive_args(value2, value)
    end
  end

end
