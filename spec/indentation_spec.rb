require File.dirname(__FILE__) + '/../lib/indentation'

describe Indentation do

  include Indentation

  describe '#unindent' do

    it 'removes excess left indentation' do
      input = <<-EOS
        This string
          should be
            unindented
      EOS

      unindent(input).should == "This string\n  should be\n    unindented\n"
    end

  end

  describe '#indent' do

    it 'adds two spaces before a single line' do
      indent('foo').should == '  foo'
    end

    it 'adds two spaces before every line' do
      indent("This string\n  should be\n    indented").should == "  This string\n    should be\n      indented"
    end

    it 'adds two spaces before every line multiplied by the specified indent level' do
      indent('foo', 2).should == '    foo'
    end

    it 'adds no space if the specified indent level is 0' do
      indent('foo', 0).should == 'foo'
    end

  end

end