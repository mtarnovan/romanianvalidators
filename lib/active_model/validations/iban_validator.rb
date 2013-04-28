module ActiveModel
  module Validations

    class IbanValidator < EachValidator

      include ActiveModel::Validations::EmptyBlankEachValidator

      # Descrierea algoritmului:
      # http://www.bnr.ro/files/d/Legislatie/EN/Reg_IBAN.pdf
      def valid?(iban)
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