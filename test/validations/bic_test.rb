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
  end

  def build_bic_record(attrs = {}, opts = {})
    TestRecord.reset_callbacks(:validate)
    TestRecord.validates :bic, :bic => true
    TestRecord.new attrs
  end

end
