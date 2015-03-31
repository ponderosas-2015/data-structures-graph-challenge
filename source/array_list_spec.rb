require_relative 'array_list'

describe ArrayList do
  let(:size) { (1..10).to_a.sample }
  let(:element) { "hello" }
  let(:array_list) { ArrayList.new(size) }

  describe '::new(size)' do
    it 'instantiates a new dynamic array' do
      expect(ArrayList.new(size)).to be_an_instance_of ArrayList
    end
    it 'returns a list with initial size (size).' do
      expect(ArrayList.new(size).size).to be(size)
    end
  end

  describe '#add(element)' do
    it 'adds an element to the end of the list.' do
      array_list.add(element)
      expect(array_list.get(array_list.size - 1)).to eq element
    end
    it 'returns the element added.' do
      expect(array_list.add(element)).to eq element
    end
  end

  describe '#get(index)' do
    it 'retrieves an element at index' do
      array_list.add(element)
      expect(array_list.get(array_list.size - 1)).to eq element
    end
  end

  describe '#set(index, element)' do
    it 'replaces an existing element at index' do
      index = (0...size).to_a.sample
      expect { array_list.set(index, element) }.to_not change{ array_list.size }.by(1)
      expect(array_list.get(index)).to eq element
    end
    it 'returns the element' do
      index = (0...size).to_a.sample
      expect(array_list.set(index, element)).to eq element
    end
  end

  describe '#size' do
    it 'returns the size of the list' do
      expect(ArrayList.new(size).size).to be(size)
    end
  end

  describe '#insert' do
    it 'should insert the value element in the ArrayList at position index' do
      index = (0...size).to_a.sample
      expect { array_list.insert(index, element) }.to change{ array_list.size }.by(1)
      expect(array_list.get(index)).to eq element
    end
  end

  describe '#reallocate' do
    it 'should return a fixed array of twice the size' do
      expect(array_list.send(:reallocate).length).to eq (size*2)
      expect(array_list.send(:reallocate)).to be_an_instance_of(FixedArray)
    end
  end
end
