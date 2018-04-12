module RomanianValidators
  module Cif
    TEST_KEY = '753217532'.to_s.chars.map(&:to_i).reverse.freeze
    FIRST_CIF = 19 # used to break iteration when direction is :down

    module_function

    def valid?(cif)
      return false unless well_formed?(cif)
      control, sum = control_sum(cif, TEST_KEY)
      sum * 10 % 11 % 10 == control
    end

    def well_formed?(cif)
      cif.present? && (2..10).cover?(cif.size) && (cif =~ /[^0-9]/).nil?
    end

    def next_valid_cif(cif)
      control, sum = control_sum(cif, TEST_KEY)
      last_digit_of_next_cif = sum * 10 % 11 % 10

      if last_digit_of_next_cif < control
        next_valid_cif(((cif / 10) + 1) * 10)
      else
        replace_last_digit(cif, last_digit_of_next_cif)
      end
    end

    def prev_valid_cif(cif)
      control, sum = control_sum(cif, TEST_KEY)
      last_digit_of_next_cif = sum * 10 % 11 % 10

      if last_digit_of_next_cif > control
        next_valid_cif(((cif / 10) - 1) * 10)
      else
        replace_last_digit(cif, last_digit_of_next_cif)
      end
    end

    def enumerator(start, direction = :up)
      Enumerator.new do |yielder|
        memo = direction == :up ? next_valid_cif(start + 1) : prev_valid_cif(start - 1)
        loop do
          yielder << memo
          memo = direction == :up ? next_valid_cif(memo + 1) : prev_valid_cif(memo - 1)
          break if memo < FIRST_CIF
        end
      end.lazy
    end

    def replace_last_digit(number, digit)
      ((number / 10).to_s + digit.to_s).to_i
    end

    def control_sum(n, test_key)
      control, *rest_digits = n.to_s.chars.map(&:to_i).reverse
      sum = rest_digits.zip(test_key).map { |a, b| a * b }.reduce(0, &:+)
      [control, sum]
    end
  end
end
