require_relative 'fixed_array'
require_relative 'oob'

class ArrayList
  attr_reader :size

  def initialize(size)
    @contents = FixedArray.new(size)
    @size = size
  end

  def add(element)
    # Amortized growth
    if @contents.length == size
      new_list = reallocate
      (0...size).each do |index|
        new_list.set(index, @contents.get(index))
      end
      @contents = new_list
    end
    @size += 1
    @contents.set(size - 1, element)
  end

  def get(index)
    @contents.get(index)
  end

  def set(index, element)
    @contents.set(index, element)
  end

  def find(element)
    @contents.find(element)
  end

  def insert(index, element)
    if @contents.length == size # Perform amortized growth
      new_list = reallocate
      (0...size).each do |i|
        if i < index
          new_list.set(i, @contents.get(i))
        elsif i >= index
          new_list.set(i + 1, @contents.get(i))
        end
      end
      @contents = new_list
    else # Make space for inserted value
      (index..size).reverse.each do |i|
        @contents.set(i, @contents.get(i-1))
      end
    end
    @size += 1
    @contents.set(index, element) # insert value
  end

  private

  def reallocate
    FixedArray.new(2*size + 1)
  end
end
