require 'active_model'

module ActiveModel
  module Validations
    def self.romanianvalidators
      %w(cif cnp iban bic)
    end

    module EmptyBlankEachValidator
      def validate_each(record, attribute, value)
        allow_blank = options.fetch(:allow_blank, false)
        allow_nil = options.fetch(:allow_nil, false)
        message = options.fetch(:message, nil)
        record.errors.add_on_empty(attribute) if value.nil? && !allow_nil
        record.errors.add_on_blank(attribute) if value.blank? && !allow_blank
        record.errors.add(attribute, message) unless valid?(value)
      end
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
