# -*- encoding: utf-8 -*-
require 'test_helper.rb'
valid_cnps = File.read('test/data/valid_cnps.txt').split

describe "Cod numeric personal" do

  describe "for valid CNPs" do
    valid_cnps.each do |cnp|
      it "accepts valid CNP" do
        subject = build_cnp_record({:cnp => cnp})
        subject.valid?.must_equal true
        subject.errors.size.must_equal 0
      end
    end
  end

  describe "for invalid CNPs" do
    it "rejects invalid CNPs and generates an error message" do
      subject = build_cnp_record :cnp => '1'
      subject.valid?.must_equal false
      subject.errors.size.must_equal 1
    end
  end

  def build_cnp_record(attrs = {}, opts = {})
    TestRecord.reset_callbacks(:validate)
    TestRecord.validates :cnp, :cnp => true
    TestRecord.new attrs
  end

end
