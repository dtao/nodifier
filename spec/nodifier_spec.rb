require File.dirname(__FILE__) + '/../lib/nodifier'

describe Nodifier do

  before :each do
    @nodifier = Nodifier.new
  end

  def node_should_match(node, hash_structure)
    keys = hash_structure.keys.to_a
    values = hash_structure[keys[0]]

    node.label.should == keys[0]

    i = 0
    node.children.each do |child|
      node_should_match child, values[i]
      i += 1
    end
  end

  def nodes_should_match(nodes, array_structure)
    i = 0
    nodes.each do |node|
      node_should_match node, array_structure[i]
      i += 1
    end
  end

  describe '@nodify' do
    it 'converts a String to a Nodes object' do
      nodes = @nodifier.nodify <<-EOS
        foo
          bar
            buzz
      EOS

      nodes_should_match nodes, [
        {
          'foo' => [
            {
              'bar' => [
                { 'buzz' => [] }
              ]
            }
          ]
        }
      ]
    end

    it 'works for multiple top-level nodes' do
      nodes = @nodifier.nodify <<-EOS
        foo
          bar
        foo
          bar
      EOS

      nodes_should_match nodes, [
        {
          'foo' => [
            { 'bar' => [] }
          ]
        },
        {
          'foo' => [
            { 'bar' => [] }
          ]
        }
      ]
    end

    it 'uses a custom parser, if one is supplied' do
      class AlwaysBobNodeParser < NodeParser
        def parse(text)
          Node.new 'bob'
        end
      end

      @nodifier = Nodifier.new(AlwaysBobNodeParser.new)
      
      nodes = @nodifier.nodify <<-EOS
        foo
          bar
            buzz
      EOS

      nodes_should_match nodes, [
        {
          'bob' => [
            {
              'bob' => [
                { 'bob' => [] }
              ]
            }
          ]
        }
      ]
    end
  end

end