require 'rubygems'

# silence warnings
old_w, $-w = $-w, false

require 'minitest/spec'
require 'minitest/mock'
require 'minitest/autorun'

# unsilence warnings
$-w = old_w

require 'romanianvalidators'
require 'active_support/core_ext/array/wrap'

class TestRecord
  include ActiveModel::Validations
  attr_accessor :cnp, :bic, :cif, :iban

  def initialize(attrs = {})
    attrs.each_pair { |k,v| send("#{k}=", v) }
  end
end
