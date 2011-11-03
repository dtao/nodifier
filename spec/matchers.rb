require File.dirname(__FILE__) + '/../lib/indentation'

RSpec::Matchers.define :be_like_block do |expected|
  include Indentation
  match do |actual|
    unindent(actual).strip == unindent(expected).strip
  end
end