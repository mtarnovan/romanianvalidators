module ActiveModel
  module Validations
    class CnpValidator < EachValidator

      TEST_KEY = "279146358279"

      include ActiveModel::Validations::EmptyBlankEachValidator

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
      def valid?(cnp)
        return false unless well_formed?(cnp) && valid_birthdate?(cnp)

        (0..11).inject(0){|sum, n| sum += TEST_KEY[n].chr.to_i * cnp[n].chr.to_i} % 11 == cnp[12].chr.to_i
      end

      private

        def well_formed?(cnp)
          (cnp=~(/[^0-9]/)).nil? && cnp.size == 13
        end

        def valid_birthdate?(cnp)
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
            Date.valid_civil?(year, cnp[3..4].to_i, cnp[5..6].to_i) ? true : false
          rescue ArgumentError
            return false
          end
        end

    end
  end
end