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
  end

  def build_cif_record(attrs = {}, opts = {})
    TestRecord.reset_callbacks(:validate)
    TestRecord.validates :cif, :cif => true
    TestRecord.new attrs
  end

end
