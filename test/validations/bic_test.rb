# -*- encoding: utf-8 -*-
require 'test_helper.rb'
valid_bics = File.read('test/data/valid_bics.txt').split

describe "BICs" do

  describe "for valid BICs" do
    valid_bics.each do |bic|
      it "accepts valid BIC" do
        subject = build_bic_record({:bic => bic})
        subject.valid?.must_equal true
        subject.errors.size.must_equal 0
      end
    end
  end

  describe "for invalid BICs" do
    it "rejects invalid BICs and generates an error message" do
      subject = build_bic_record :bic => '1'
      subject.valid?.must_equal false
      subject.errors.size.must_equal 1
    end

    it "rejects invalid BICs and allows custom error message" do
      message = "Some custom error message"
      subject = build_bic_record({:bic => '1'}, {:message => message})
      subject.valid?.must_equal false
      subject.errors.size.must_equal 1
      subject.errors[:bic].must_equal Array.wrap(message)
    end
  end

  def build_bic_record(attrs = {}, opts = {})
    custom_message = opts.fetch(:message, false)
    TestRecord.reset_callbacks(:validate)
    if custom_message
      TestRecord.validates :bic, :bic => {:message => custom_message}
    else
      TestRecord.validates :bic, :bic => true
    end
    TestRecord.new attrs
  end

end
