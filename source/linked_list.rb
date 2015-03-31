require_relative 'll_node'
require_relative 'oob'

class LinkedList
  attr_reader :size

  def initialize
    @head = nil
    @tail = nil
    @size = 0
  end

  def insert_first(node)
    old_head, @head = @head, node
    @head.insert_after(old_head) if old_head
    @size += 1
    @tail = @head if size == 1
    node
  end

  def remove_first
    return nil if @head.nil?
    old_head, @head = @head, @head.next
    @size -= 1
    @tail = nil if size.zero?
    old_head
  end

  def insert_last(node)
    @size += 1
    if @tail.nil?
      @head, @tail = node, node
    else
      @tail = @tail.insert_after(node)
    end
  end

  def remove_last
    return nil if @tail.nil?
    if size == 1
      removed_node, @head, @tail = @head, nil, nil
    else
      @tail = @tail.prev
      removed_node = @tail.remove_after
    end
    @size -= 1
    removed_node
  end

  def get(index)
    check_bounds!(index)
    traverse(index)
  end

  def find(element, current_node = @head, index = 0)
    return -1 if current_node.nil?
    return index if current_node.element == element
    index += 1
    find(element, current_node.next, index)
  end

  def set(index, element)
    check_bounds!(index)
    traverse(index).element = element
  end

  def remove(index)
    begin
      removed_node = get(index)
    rescue OutOfBoundsError
      return nil
    end

    if removed_node.prev.nil?
      remove_first
    elsif removed_node.next.nil?
      remove_last
    else
      removed_node.prev.insert_after(removed_node.next)
      @size -= 1
      removed_node
    end
  end

  private

  def traverse(distance, current_node = @head)
    if distance.zero?
      current_node
    else
      traverse(distance - 1, current_node.next)
    end
  end

  def check_bounds!(index)
    raise OutOfBoundsError unless index.is_a?(Integer) && index < size && index > -1
  end
end
