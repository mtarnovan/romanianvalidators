module RomanianValidators
  module Cnp
    TEST_KEY = '279146358279'.each_char.map(&:to_i)

    module_function

    def valid?(cnp)
      return false unless well_formed?(cnp) && valid_birthdate?(cnp)
      control = (0..11).reduce(0) { |acc, elem| acc + TEST_KEY[elem] * cnp[elem].chr.to_i } % 11
      control = 1 if control == 10
      control == cnp[12].chr.to_i
    end

    def well_formed?(cnp)
      (cnp =~ /[^0-9]/).nil? && cnp.size == 13
    end

    def valid_birthdate?(cnp)
      year_code = cnp[0].chr.to_i
      year =
        case year_code
        when 1..2 then '19'
        when 3..4 then '18'
        when 5..6 then '20'
        when 9    then '19' # oare se sare peste un an bisect intre 1800-2099 ?
        else return false
        end
      year = (year + cnp[1..2]).to_i
      Date.valid_civil?(year, cnp[3..4].to_i, cnp[5..6].to_i) ? true : false
    rescue ArgumentError
      return false
    end
  end
end
