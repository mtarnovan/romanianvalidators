module RomanianValidators
  module ActiveModel
    module Validations
      class BicValidator < ::ActiveModel::EachValidator
        include ActiveModel::Validations::EmptyBlankEachValidator

        def valid?(bic)
          RomanianValidators::Bic.valid?(bic)
        end
      end
    end
  end
end
