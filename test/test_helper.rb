require 'rubygems'

# silence warnings
old_w, $-w = $-w, false

require 'minitest/spec'
require 'minitest/mock'
require 'minitest/autorun'

# unsilence warnings
$-w = old_w

require 'romanianvalidators'
require 'romanianvalidators/active_model'
require 'active_support/core_ext/array/wrap'

I18n.enforce_available_locales = true

class TestRecord
  include ActiveModel::Validations
  include RomanianValidators::ActiveModel::Validations
  attr_accessor :cnp, :bic, :cif, :iban

  def initialize(attrs = {})
    attrs.each_pair { |k,v| send("#{k}=", v) }
  end
end
