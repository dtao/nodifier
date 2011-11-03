require File.dirname(__FILE__) + '/indentation'
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

  def to_s(indent_level = 0)
    s = indent(@label, indent_level)

    @children.each do |child|
      s << "\n"
      s << indent(child.to_s, indent_level + 1)
    end

    s
  end

  def to_xml
    @@xml_formatter.format self
  end
end