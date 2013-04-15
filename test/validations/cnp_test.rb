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
    it "rejects invalid cnps and allows custom error message" do
      message = "Some custom error message"
      subject = build_cnp_record({:cnp => '1'}, {:message => message})
      subject.valid?.must_equal false
      subject.errors.size.must_equal 1
      subject.errors[:cnp].must_equal Array.wrap(message)
    end
  end

  def build_cnp_record(attrs = {}, opts = {})
    custom_message = opts.fetch(:message, false)
    TestRecord.reset_callbacks(:validate)
    if custom_message
      TestRecord.validates :cnp, :cnp => {:message => custom_message}
    else
      TestRecord.validates :cnp, :cnp => true
    end
    TestRecord.new attrs
  end

end
