class Node
  attr_reader :label
  attr_reader :children

  def initialize(label)
    @label = label
    @children = []
  end
end