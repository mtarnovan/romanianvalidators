module RomanianValidators
  module ActiveModel
    module Validations
      class CnpValidator < ::ActiveModel::EachValidator
        include ActiveModel::Validations::EmptyBlankEachValidator

        def valid?(cnp)
          RomanianValidators::Cnp.valid?(cnp)
        end
      end
    end
  end
end
