module ActiveModel
  module Validations

    class CifValidator < EachValidator
      def validate_each(record, attribute, value)
        allow_blank = options.fetch(:allow_blank, false)
        allow_nil = options.fetch(:allow_nil, false)
        message = options.fetch(:message, nil)
        record.errors.add_on_empty(attribute) if value.nil? && !allow_nil
        record.errors.add_on_blank(attribute) if value.blank? && !allow_blank
        record.errors.add(attribute, message) unless Cif.valid?(value)
      end

      # Algoritmul de validare al unui cod CUI
      # Pas preliminar: Se testeaza daca codul respecta formatul unui cod CUI. Adica lungimea maxima sa fie de 10 cifre si sa contina doar caractere numerice.
      # Pas 1: Se foloseste cheia de testare "753217532". Se inverseaza ordinea cifrelor codului CUI precum si a cheii de testare.
      # Pas 2: Se ignora prima cifra din codul CUI inversat (aceasta este cifra de control) si se inmulteste fiecare cifra cu cifra corespunzatoare din cheia de testare inversata.
      # Pas 3: Se aduna toate produsele obtinute. Suma rezultata se inmulteste cu 10 si apoi se afla restul impartirii la 11.
      # Pas 4: Pentru un CUI valid cifra obtinuta, in urma operatiei MODULO 11, va trebui sa corespunda cu cifra de control a codului CUI initial .
      class Cif
        def self.valid?(cif)
          return false if cif.nil?
          return false if cif.size > 10 || cif.size < 2
          return false unless (cif=~(/[^0-9]/)).nil?
          rk = "235712357".freeze # reversed test key (753217532)
          rc = cif.reverse.freeze
          (1..(cif.size - 1)).inject(0) {|sum, n| sum += rk[n-1].chr.to_i * rc[n].chr.to_i}  * 10 % 11 % 10 == rc[0].chr.to_i
        end
      end
    end

  end
end