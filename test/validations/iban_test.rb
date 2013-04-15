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
    it "rejects invalid ibans and allows custom error message" do
      message = "Some custom error message"
      subject = build_iban_record({:iban => '1'}, {:message => message})
      subject.valid?.must_equal false
      subject.errors.size.must_equal 1
      subject.errors[:iban].must_equal Array.wrap(message)
    end
  end

  def build_iban_record(attrs = {}, opts = {})
    custom_message = opts.fetch(:message, false)
    TestRecord.reset_callbacks(:validate)
    if custom_message
      TestRecord.validates :iban, :iban => {:message => custom_message}
    else
      TestRecord.validates :iban, :iban => true
    end
    TestRecord.new attrs
  end

end
