require_relative 'set'

describe MySet do
  let(:element) { "hello" }
  let(:element2) { "world" }
  let(:element3) { "andy" }
  let(:my_set) { MySet.new }
  let(:my_first_set) do
    x = MySet.new
    x.add(element)
    x.add(element2)
    x
  end
  let(:my_other_set) do
    x = MySet.new
    x.add(element)
    x.add(element3)
    x
  end

  describe '#new()' do
    it 'Instantiates a new empty Set.' do
      expect(MySet.new).to be_an_instance_of MySet
    end
  end

  describe '#add(element)' do
    it 'Add an element to the set (if necessary)' do
      expect(my_set.contains?(element)).to be false
      expect{ my_set.add(element) }.to change{my_set.size}.by(1)
      expect(my_set.contains?(element)).to be true
      expect{ my_set.add(element) }.not_to change{my_set.size}.by(1)
    end
  end

  describe '#remove(element)' do
    it 'Remove element from the set if it\'s present' do
      my_set.add(element)
      expect(my_set.contains?(element)).to be true
      expect{ my_set.remove(element) }.to change{my_set.size}.by(-1)
      expect(my_set.contains?(element)).to be false
    end
  end

  describe '#contains?(element)' do
    it 'Answer whether or not element is in the set' do
      expect(my_set.contains?(element)).to be false
      my_set.add(element)
      expect(my_set.contains?(element)).to be true
    end
  end

  describe '#iterate{ |element| block }' do
    it 'Iterate through all of the elements of the receiver' do
      my_set.add(element)
      my_set.add(element2)
      expect{ |b|
        my_set.iterate(&b)
      }.to yield_successive_args(element, element2)
    end
  end

  describe '#size' do
    it 'Return the size of the set' do
      expect(my_set.size).to be 0
      my_set.add(element)
      expect(my_set.size).to be 1
      my_set.add(element)
      expect(my_set.size).to be 1
    end
  end

  describe '#union(other_set)' do
    it 'Returns a new set that is the union of this set and other_set' do
      union_set = my_first_set.union(my_other_set)
      expect(union_set).to be_an_instance_of MySet
      expect(union_set).not_to eq my_first_set
      expect(union_set).not_to eq my_other_set
      expect(union_set.size).to be (3)
      expect(union_set.contains?(element)).to be true
    end
  end

  describe '#intersection(other_set)' do
    it 'Return a new set that is the intersection of this set and other_set' do
      intersection_set = my_first_set.intersection(my_other_set)
      expect(intersection_set).to be_an_instance_of MySet
      expect(intersection_set).not_to eq my_first_set
      expect(intersection_set).not_to eq my_other_set
      expect(intersection_set.size).to be (1)
      expect(intersection_set.contains?(element)).to be true
    end
  end

  describe '#difference(other_set)' do
    it 'Return a new set that contains this elements in the set that aren\'t in other_set' do
      difference_set = my_first_set.difference(my_other_set)
      expect(difference_set).to be_an_instance_of MySet
      expect(difference_set).not_to eq my_first_set
      expect(difference_set).not_to eq my_other_set
      expect(difference_set.size).to be (1)
      expect(difference_set.contains?(element)).to be false
      expect(difference_set.contains?(element2)).to be true
    end
  end

  describe '#subset?(other_set)' do
    it 'Answers whether or not other_set is a subset of this set' do
      expect(my_first_set.subset?(my_other_set)).to be false
      my_sub_set = MySet.new
      my_sub_set.add(element)
      expect(my_first_set.subset?(my_sub_set)).to be true
    end
  end
end
