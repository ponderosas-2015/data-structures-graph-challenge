require_relative 'linked_list'
require_relative 'll_node'

class MySet

  def initialize
    # LinkedList shrinks & scales better than ArrayList
    @items = LinkedList.new
  end

  def add(element)
    @items.insert_last(LLNode.new(element)) unless contains?(element)
  end

  def remove(element)
    @items.remove(@items.find(element)) if contains?(element)
  end

  def contains?(element)
    @items.find(element) > -1
  end

  def size
    @items.size
  end

  def iterate
    node = @items.get(0)
    size.times do
      yield node.element
      node = node.next
    end
  end

  def union(other_set)
    union_set = MySet.new
    self.iterate do |item|
      union_set.add(item)
    end
    other_set.iterate do |item|
      union_set.add(item)
    end
    union_set
  end

  def intersection(other_set)
    intersection_set = MySet.new
    self.iterate do |item|
      intersection_set.add(item) if other_set.contains?(item)
    end
    intersection_set
  end

  def difference(other_set)
    difference_set = MySet.new
    self.iterate do |item|
      difference_set.add(item) unless other_set.contains?(item)
    end
    difference_set
  end

  def subset?(other_set)
    other_set.iterate do |item|
      return false unless contains?(item)
    end
    true
  end
end
