class Nodes < Array
  def to_s(indent_level = 0, &formatter_block)
    s = ''

    each do |node|
      s << "\n" unless s.empty?
      s << node.to_s(indent_level, &formatter_block)
    end

    s
  end
end