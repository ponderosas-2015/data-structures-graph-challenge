require_relative 'oob'

class FixedArray

  def initialize(size)
    @contents = Array.new(size)
  end

  def length
    @contents.length
  end

  def get(index)
    if !index.is_a?(Integer) || index >= length
      raise OutOfBoundsException.new, "There are only #{length} elements in FixedArray"
    end
    @contents[index]
  end

  def find(element)
    count = 0
    length.times do
      return count if get(count) == element
      count += 1
    end
    return -1
  end

  def set(index, element)
    if !index.is_a?(Integer) || index >= length
      raise OutOfBoundsException.new, "There are only #{length} elements in FixedArray"
    end
    @contents[index] = element
  end

end
