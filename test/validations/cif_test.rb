# -*- encoding: utf-8 -*-
require 'test_helper.rb'
valid_cifs = File.read('test/data/valid_cifs.txt').split

describe "Cod de identificare fiscală" do

  describe "for valid CIFs" do
    valid_cifs.each do |cif|
      it "accepts valid CIF" do
        subject = build_cif_record({:cif => cif})
        subject.valid?.must_equal true
        subject.errors.size.must_equal 0
      end
    end
  end

  describe "for invalid CIFs" do
    it "rejects invalid CIFs and generates an error message" do
      subject = build_cif_record :cif => '1'
      subject.valid?.must_equal false
      subject.errors.size.must_equal 1
    end

    it "rejects invalid CIFs and allows custom error message" do
      message = "Some custom error message"
      subject = build_cif_record({:cif => '1'}, {:message => message})
      subject.valid?.must_equal false
      subject.errors.size.must_equal 1
      subject.errors[:cif].must_equal Array.wrap(message)
    end

  end

  def build_cif_record(attrs = {}, opts = {})
    custom_message = opts.fetch(:message, false)
    TestRecord.reset_callbacks(:validate)
    if custom_message
      TestRecord.validates :cif, :cif => {:message => custom_message}
    else
      TestRecord.validates :cif, :cif => true
    end
    TestRecord.new attrs
  end

end