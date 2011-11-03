class FormatterState
  def initialize
    @formatted_children = false
  end

  def children_are_formatted!
    @formatted_children = true
  end

  def formatted_children?
    @formatted_children
  end
end