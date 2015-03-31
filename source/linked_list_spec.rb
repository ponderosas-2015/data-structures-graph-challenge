require_relative 'linked_list'
require_relative 'll_node'
require_relative 'oob'

describe LinkedList do
  let(:element) { "hello" }
  let(:element2) { "world" }
  let(:element3) { "foo" }
  let(:node) { LLNode.new(element) }
  let(:node2) { LLNode.new(element2) }
  let(:node3) { LLNode.new(element3) }
  let(:linked_list) { LinkedList.new }

  describe '#new' do
    it 'instantiates a new linked list' do
      expect(LinkedList.new).to be_an_instance_of LinkedList
    end
  end

  describe '#insert_first(element)' do
    it 'insert an element at the front of the list' do
      linked_list.insert_first(node)
      expect(linked_list.get(0)).to eq node
    end
  end

  describe '#remove_first' do
    it 'removes the element at the front of the list' do
      linked_list.insert_first(node)
      linked_list.insert_first(node2)
      expect(linked_list.remove_first).to eq node2
      expect(linked_list.get(0)).to eq node
    end

    it 'nil if absent' do
      expect(linked_list.remove_first).to eq nil
    end
  end

  describe '#insert_last(element)' do
    it 'insert an element at the back of the list' do
      linked_list.insert_last(node)
      linked_list.insert_last(node2)
      expect(linked_list.get(0)).to eq node
      expect(linked_list.get(1)).to eq node2
      expect(linked_list.size).to be(2)
    end
  end

  describe '#remove_last' do
    it 'removes the element at the back of the list' do
      linked_list.insert_last(node)
      linked_list.insert_last(node2)
      expect(linked_list.remove_last).to eq node2
      expect(linked_list.get(0)).to eq node
      expect(linked_list.size).to be(1)
    end
    it 'nil if absent' do
      expect(linked_list.remove_last).to eq nil
    end
  end

  describe '#remove(index)' do
    it 'removes the element at the specified index' do
      linked_list.insert_last(node)
      linked_list.insert_last(node2)
      linked_list.insert_last(node3)
      expect{linked_list.remove(1)}.to change{linked_list.size}.by(-1)
      expect(linked_list.get(0)).to eq node
      expect(linked_list.get(1)).to eq node3
      expect(linked_list.remove(1)).to eq node3
    end
    it 'nil if absent' do
      expect(linked_list.remove(1)).to eq nil
    end
  end

  describe '#get(index)' do
    it 'gets the element in the list at index' do
      linked_list.insert_last(node)
      linked_list.insert_last(node2)
      expect(linked_list.get(1)).to eq node2
    end
  end

  describe '#set(index, element)' do
    it 'sets the element in the list at index' do
      linked_list.insert_last(node)
      linked_list.insert_last(node2)
      expect{linked_list.set(0,element3)}
          .to change{linked_list.get(0).element}.from(element).to(element3)
    end
  end

  describe '#find(element)' do
    it 'finds the index of an element in a linked list' do
      linked_list.insert_last(node)
      linked_list.insert_last(node2)
      expect(linked_list.find(element)).to be(0)
      expect(linked_list.find(element2)).to be(1)
    end
    it 'returns -1 if an element is not in a linked list' do
      expect(linked_list.find(element3)).to be(-1)
    end
  end

  describe '#size' do
    it 'returns the size of the linked list' do
      expect(linked_list.size).to be(0)
      linked_list.insert_last(node)
      expect(linked_list.size).to be(1)
      linked_list.insert_last(node2)
      expect(linked_list.size).to be(2)
      linked_list.remove_first
      expect(linked_list.size).to be(1)
    end
  end

  describe '#traverse(distance, start)' do
    it 'returns nil when list is empty' do
      expect(linked_list.send(:traverse, 0)).to be nil
    end
    it 'returns a node distance from start' do
      linked_list.insert_last(node)
      linked_list.insert_last(node2)
      expect(linked_list.send(:traverse, 0)).to be node
      expect(linked_list.send(:traverse, 1)).to be node2
      expect(linked_list.send(:traverse, 2)).to be nil
    end
  end

  describe '#check_bounds!(index)' do
    it 'raises an OutOfBoundsError when index >= size' do
      linked_list.insert_last(node)
      linked_list.insert_last(node2)
      expect{linked_list.send(:check_bounds!, 2)}.to raise_error(OutOfBoundsError)
    end
  end
end
