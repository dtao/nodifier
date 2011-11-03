require File.dirname(__FILE__) + '/indentation'
require File.dirname(__FILE__) + '/stopper'
require File.dirname(__FILE__) + '/xml_node_formatter'

class Node
  include Indentation

  @@xml_formatter = XmlNodeFormatter.new

  attr_reader :label
  attr_reader :children

  def initialize(label)
    @label = label
    @children = []
  end

  def to_s(indent_level = 0, &formatter_block)
    if not block_given?
      return to_s(indent_level) { |node| node.label }
    end

    stopper = Stopper.new
    case formatter_block.arity
    when 1:
      s = indent(formatter_block.call(self), indent_level)
    when 2:
      s = indent(formatter_block.call([self, stopper]), indent_level)
    end

    unless stopper.stopped?
      @children.each do |child|
        s << "\n"
        s << child.to_s(indent_level + 1, &formatter_block)
      end
    end

    s
  end

  def to_xml
    @@xml_formatter.format self
  end
end