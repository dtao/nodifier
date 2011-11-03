Introduction
============

*Nodifier* is intended as a very simple library to parse plain text into a node-based structure.

The basic idea behind *nodifier* is that it can be used to devise a system of storing domain-specific information in a textual format that is as _concise_ and _human-readable_ as possible.

At the heart of *nodifier* is the `Node` class:

```ruby
class Node
  attr_reader :label
  attr_reader :children

  def initialize(label)
    @label = label
    @children = []
  end
end
```

Example
=======

Given the following plain text...

```
foo
  bar
  	a
  	b
  	c
  buzz
  	x
  	y
  	z
```

...*nodifier* will parse this as an array of `Node` objects with the following structure (expressed below as XML for no particular reason):

```xml
<foo>
  <bar>
    <a />
    <b />
    <c />
  </bar>
  <buzz>
    <x />
    <y />
    <z />
  </buzz>
</foo>
```