module RomanianValidators
  module ActiveModel
    module Validations
      class IbanValidator < ::ActiveModel::EachValidator
        include ActiveModel::Validations::EmptyBlankEachValidator

        def valid?(iban)
          RomanianValidators::Iban.valid?(iban)
        end
      end
    end
  end
end