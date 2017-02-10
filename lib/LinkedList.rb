class LinkedList
include Enumerable

attr_reader :head, :tail, :size

  def initialize(*values)
    @head = Node.new(values.shift)
    @tail = @head
    @size = self.empty? ? 0 : 1
    values.each { |v| self.append v }
  end


  def append(node_value)
    return self.prepend(node_value) if self.empty?

    @tail.next = Node.new(node_value)
    @tail = @tail.next
    @size += 1
    return self
  end


  def prepend(node_value)
    if self.empty?
      @head = Node.new(node_value)
      @tail = @head
    else
      @head = Node.new(node_value, @head)
    end
    @size += 1
    return self
  end


  def [](i)
    return nil if @size <= (i >= 0 ? i : (i + 1).abs)

    tmp = @head

    i.times { tmp = tmp.next } if i >= 0
    (@size + i).times { tmp = tmp.next } if i < 0

    return tmp
  end


  def []=(i, v) 
    return self.prepend(v) if self.empty? && i == 0
    self[i].value = v unless self[i] == nil
  end


  def pop ## Can be refactored with remove_at(-1)
    tmp = @tail

    case @size
    when 0
      return tmp
    when 1 
      @head = Node.new()
      @tail = @head
    else
      @tail = self[-2]
      @tail.next = nil
    end

    @size -= 1

    return tmp
  end


  def contains?(v)
    self.include? v
  end


  def find(v)
    self.each_with_index { |e, i| return i if e == v }
    return nil
  end


  def to_s
    string = ( @size == 0 ? "(   )" : "" )

    self.each do |e|
      string << "( #{e} )"
      string << " -> " unless e.next == nil
    end

    return string
  end


  def remove_at(i) ## Refactor?
    tmp = self[i]
    trans_i = ( i >= 0 ? i : @size + i )

    case @size
    when 0
      return tmp
    when 1 
      return tmp unless trans_i == 0
      @head = Node.new()
      @tail = @head
    else
      if trans_i == 0
        @head = self[1]
      else
        self[i - 1].next = self[i].next
      end
    end

    @size -= 1

    return tmp
  end


  def inspect
    return self.to_s
  end


  def empty?
    return @head.empty?
  end

  
  def each
    return enum_for(__method__) unless block_given?
    for i in (0... self.size)
      yield(self[i])
    end
    return self
  end


  private


  class Node
  attr_accessor :value, :next
  
    def initialize(value=nil, next_node=nil)
      @value = value
      @next = next_node
    end
  

    def empty?
      return @value == nil && @next == nil
    end
  

    def ==(v)
      return @value == v
    end
  

    def to_s
      return @value.to_s 
    end
  

    def inspect
      self.to_s
    end

  end
end
