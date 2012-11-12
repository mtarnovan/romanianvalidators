require 'active_model'

module ActiveModel
  module Validations
    def self.romanianvalidators
      %w(cif cnp iban bic)
    end

    romanianvalidators.each do |validator_name|
      require "active_model/validations/#{validator_name}_validator"
    end

    module HelperMethods
      ActiveModel::Validations.romanianvalidators.each do |validator|
        define_method('validates_' + validator) do |*fields|
          options ||= (fields.delete fields.find { |f| f.kind_of? Hash}) || true
          args = fields.push({ validator => options })
          validates(*args)
        end
      end
    end
  end
end
