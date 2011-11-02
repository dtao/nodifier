require File.dirname(__FILE__) + '/../lib/indentation'

describe Indentation do

  include Indentation

  describe '#unindent' do

    it 'removes excess left indentation' do
      input = <<-EOS
        This string
          should be
            fixed
      EOS

      unindent(input).should == "This string\n  should be\n    fixed\n"
    end

  end

end