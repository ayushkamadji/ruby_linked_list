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
