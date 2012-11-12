# -*- encoding: utf-8 -*-
require 'test_helper.rb'
valid_ro_ibans = File.read('test/data/valid_ro_ibans.txt').split

describe "Iban (BNR only)" do

  describe "for valid romanian IBANs" do
    valid_ro_ibans.each do |iban|
      it "accepts valid IBAN" do
        subject = build_iban_record({:iban => iban})
        subject.valid?.must_equal true
        subject.errors.size.must_equal 0
      end
    end
  end

  describe "for invalid IBANs" do
    it "rejects invalid IBANs and generates an error message" do
      subject = build_iban_record :iban => '1'
      subject.valid?.must_equal false
      subject.errors.size.must_equal 1
    end
  end

  def build_iban_record(attrs = {}, opts = {})
    TestRecord.reset_callbacks(:validate)
    TestRecord.validates :iban, :iban => true
    TestRecord.new attrs
  end

end
