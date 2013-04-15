module ActiveModel
  module Validations

    class IbanValidator < EachValidator
      def validate_each(record, attribute, value)
        allow_blank = options.fetch(:allow_blank, false)
        allow_nil = options.fetch(:allow_nil, false)
        message = options.fetch(:message, nil)
        record.errors.add_on_empty(attribute) if value.nil? && !allow_nil
        record.errors.add_on_blank(attribute) if value.blank? && !allow_blank
        record.errors.add(attribute, message) unless Iban.valid?(value)
      end

      # Descrierea algoritmului:
      # http://www.bnr.ro/files/d/Legislatie/EN/Reg_IBAN.pdf
      class Iban
        def self.valid?(iban)
          return false if iban.size < 3
          use_ord = "".respond_to?(:ord) # Ruby 1.9
          (iban.slice(4,iban.size) + iban[0..3]).upcase.gsub(/[A-Z]/) do |s|
            use_ord ? (s[0].ord - 55).to_s : (s[0].to_i - 55).to_s
          end.to_i % 97 == 1
        rescue
          false
        end
      end
    end

  end
end