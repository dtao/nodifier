class Nodes < Array
  def to_s(indent_level = 0, &formatter_block)
    map { |node| node.to_s(indent_level, &formatter_block) }.join("\n")
  end

  def to_json
    map { |node| node.to_json }.join("\n")
  end

  def to_xml
    map { |node| node.to_xml }.join("\n")
  end
end