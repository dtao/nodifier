require File.dirname(__FILE__) + '/../lib/node'
require File.dirname(__FILE__) + '/../lib/nodifier'

describe Node do

  describe '#to_s' do
    context 'node without children' do
      before :each do
        @node = Node.new 'foo'
      end

      it 'returns the node\'s label' do
        @node.to_s.should == 'foo'
      end
    end

    context 'node with children' do
      before :each do
        @node = Node.new 'foo'
        @node.children << Node.new('bar')
        @node.children << Node.new('buzz')
      end

      it 'returns an indented list comprising the node\'s label and child nodes\' labels' do
        @node.to_s.should == "foo\n  bar\n  buzz"
      end

      it 'works for any arbitrary amount of nesting' do
        @node = Nodifier.new.nodify <<-EOS
          foo
           bar
            buzz
             a
              b
               c
        EOS

        @node.to_s.should == "foo\n  bar\n    buzz\n      a\n        b\n          c"
      end

      it 'can accept a formatter block with which to format each node' do
        @node.to_s { |node| 'blah' }.should == "blah\n  blah\n  blah"
      end
    end
  end
  
  describe '#to_xml' do
    it 'renders the node the same as XmlNodeFormatter' do
      node = Node.new 'foo'
      node.children << Node.new('bar')
      node.children << Node.new('buzz')

      node.to_xml.should == "<foo>\n  <bar />\n  <buzz />\n</foo>"
    end
  end

end