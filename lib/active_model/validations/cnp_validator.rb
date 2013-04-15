module ActiveModel
  module Validations

    class CnpValidator < EachValidator
      def validate_each(record, attribute, value)
        allow_blank = options.fetch(:allow_blank, false)
        allow_nil = options.fetch(:allow_nil, false)
        message = options.fetch(:message, nil)
        record.errors.add_on_empty(attribute) if value.nil? && !allow_nil
        record.errors.add_on_blank(attribute) if value.blank? && !allow_blank
        record.errors.add(attribute, message) unless Cnp.valid?(value)
      end

      # Algoritm de validare CNP
      # Pas preliminar: Se testeaza daca codul respecta formatul unui cod CNP. 
      # Adica prima cifra sa fie cuprinsa in intervalul 1 - 6 sau sa fie 9 pentru straini. 
      # Urmatoarele sase cifre trebuie sa constituie o data calendaristica valida in formatul AALLZZ.
      #
      # Pas 1: 
      # Se foloseste cheia de testare "279146358279". Primele douasprezece cifre se inmultesc pe rand de la 
      # stanga spre dreapta cu cifra corespunzatoare din cheia de testare.
      #
      # Pas 2: Cele douasprezece produse obtinute se aduna si suma obtinuta se imparte la 11. Restul impartirii 
      # reprezinta cifra de control. Pentru un CNP valid acest rest va trebui sa coincida cu cifra de pe 
      # pozitia treisprezece din CNP-ul initial. 
      class Cnp
        def self.valid?(cnp)
          return false unless (cnp=~(/[^0-9]/)).nil? && cnp.size == 13
          require 'date'
          begin
            year = case
            when
              cnp[0].chr == "1" || cnp[0].chr == "2" then "19"
            when
              cnp[0].chr == "3" || cnp[0].chr == "4" then "18"
            when
              cnp[0].chr == "5" || cnp[0].chr == "6" then "20"
            when
              cnp[0].chr == "9" then "19" # oare se sare peste un an bisect intre 1800-2099 ?
            else return false;
            end

            year = (year + cnp[1..2]).to_i
            return false unless Date.valid_civil?(year,cnp[3..4].to_i,cnp[5..6].to_i)
          rescue ArgumentError
            return false
          end
          test_key = "279146358279"
           (0..11).inject(0){|sum, n| sum += test_key[n].chr.to_i * cnp[n].chr.to_i} % 11 == cnp[12].chr.to_i
        end
      end
    end

  end
end