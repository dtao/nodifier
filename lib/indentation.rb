module Indentation

  def unindent(content)
    output = ''

    first_line = content.lines.first
    leading_spaces = first_line.length - first_line.lstrip.length

    content.lines do |line|
      output << line[leading_spaces..-1] || ''
    end

    output
  end

  def indent(content, indent_level = 1)
    output = ''

    content.lines do |line|
      output << ('  ' * indent_level) + line
    end

    output
  end

end