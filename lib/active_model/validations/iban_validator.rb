module ActiveModel
  module Validations
    class IbanValidator < EachValidator

      # use ord for ruby >= 1.9
      USE_ORD = "".respond_to?(:ord)

      include ActiveModel::Validations::EmptyBlankEachValidator

      # Descrierea algoritmului:
      # http://www.bnr.ro/files/d/Legislatie/EN/Reg_IBAN.pdf
      def valid?(iban)
        return false if iban.size < 3
        transpose((iban.slice(4, iban.size) + iban[0..3])).to_i % 97 == 1
      rescue
        false
      end

      private

        # replace letters according to algorithm
        # algorithm conversion maps chars to ASCII value - 55
        def transpose(iban)
          iban.upcase.gsub(/[A-Z]/) do |s|
            USE_ORD ? (s[0].ord - 55).to_s : (s[0].to_i - 55).to_s
          end
        end

    end
  end
end