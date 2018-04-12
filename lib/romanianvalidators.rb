module RomanianValidators
  def self.available_validators
    %w(cif cnp iban bic)
  end

  available_validators.each do |validator_name|
    require "romanianvalidators/#{validator_name}"
  end
end
