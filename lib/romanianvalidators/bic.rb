module RomanianValidators
  module Bic
    COUNTRY_CODES =
      %w(AF AL DZ AS AD AO AI AG AR AM AW AU AT AZ BS BH BD BB BY BE BZ BJ BM
         BT BO BA BW BR BN BG BF BI KH CM CA CV KY CF TD CL CN CO KM CG CD CK CR
         CI HR CU CY CZ DK DJ DM DO EC EG SV GQ ER EE ET FK FO FJ FI FR GF PF GA
         GM GE DE GH GI GR GL GD GP GU GT GN GW GY HT VA HN HK HU IS IN ID IR IQ
         IE IL IT JM JP JO KZ KE KI KP KR KW KG LA LV LB LS LR LY LI LT LU MO MK
         MG MW MY MV ML MT MH MQ MR MU MX FM MD MC MN MS MA MZ MM NA NR NP NL AN
         NC NZ NI NE NG NU NF MP NO OM PK PW PA PG PY PE PH PN PL PT PR QA RE RO
         RU RW SH KN LC PM VC WS SM ST SA SN SC SL SG SK SI SB SO ZA ES LK SD SR
         SJ SZ SE CH SY TW TJ TZ TH TG TK TO TT TN TR TM TC TV UG UA AE GB US UY
         UZ VU VE VN VG VI WF EH YE ZM ZW).freeze

    module_function

    # This is only a basic validation of a BIC
    # http://www.swift.com/biconline/index.cfm?fuseaction=display_aboutbic
    def valid?(bic)
      return false unless bic.size == 8 || bic.size == 11 # length 8 or 11
      return false unless (bic[0..3] =~ /[^A-Z]/).nil? # first 4 must be letters only
      COUNTRY_CODES.include?(bic[4..5])
    end
  end
end
