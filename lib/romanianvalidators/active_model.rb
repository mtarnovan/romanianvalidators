require 'romanianvalidators'
require 'active_model'
module RomanianValidators
  module ActiveModel
    module Validations
      module EmptyBlankEachValidator
        def validate_each(record, attribute, value)
          allow_blank = options.fetch(:allow_blank, false)
          allow_nil = options.fetch(:allow_nil, false)
          message = options.fetch(:message, :invalid)
          record.errors.add_on_empty(attribute) && return if value.nil? && !allow_nil
          record.errors.add_on_blank(attribute) && return if value.blank? && !allow_blank
          record.errors.add(attribute, message) && return unless valid?(value)
        end
      end

      RomanianValidators.available_validators.each do |validator_name|
        require "romanianvalidators/active_model/validations/#{validator_name}_validator"
      end

      module HelperMethods
        RomanianValidators.available_validators.each do |validator|
          define_method('validates_' + validator) do |*fields|
            options ||= fields.delete(fields.find { |f| f.is_a? Hash }) || true
            args = fields.push(validator => options)
            validates(*args)
          end
        end
      end
    end
  end
end
