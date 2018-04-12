module RomanianValidators
  module ActiveModel
    module Validations
      class CifValidator < ::ActiveModel::EachValidator
        include ActiveModel::Validations::EmptyBlankEachValidator

        def valid?(cif)
          RomanianValidators::Cif.valid?(cif)
        end
      end
    end
  end
end
