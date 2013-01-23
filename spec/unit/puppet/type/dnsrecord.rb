require 'puppet'

require File.dirname(__FILE__) + '/../../../spec_helper'

describe Puppet::Type.type(:dnsrecord) do

  it do
    expect {
      Puppet::Type.type(:dnsrecord).new(:name => '')
    }.to raise_error(Puppet::Error, /Name must not be empty/)
  end

  # check to make sure all parameters can be specified
  params = [
  'zone',
  ].each do |param|
    context "when a valid dnsrecord parameter #{param} => is specified (ends w period)" do
      it "should not raise an error" do
        expect {
          Puppet::Type.type(:dnsrecord).new(:name => 'test', param => "blah.")
          }.to_not raise_error
      end
    end
  end
  
  params = [
  'value',
  'type',
  'server',
  ].each do |param|
    context "when a valid dnsrecord parameter #{param} => is specified (std string)" do
      it "should not raise an error" do
        expect {
          Puppet::Type.type(:dnsrecord).new(:name => 'test', param => "blah")
          }.to_not raise_error
      end
    end
  end

 params = [
  'ttl',
  ].each do |param|
    context "when a valid dnsrecord ttl #{param} => is specified (integer)" do
      it "should not raise an error" do
        expect {
          Puppet::Type.type(:dnsrecord).new(:name => 'test', param => 500)
          }.to_not raise_error
      end
    end
  end

  
# check to make sure type accepts  only valid RR types
   params = [
  'type',
  ].each do |param|
    context "when a valid RR parameter #{param} => requiring specified type is specified  #{param}" do
      validRR = [
        'A',
        'PTR',
        'CNAME',
        'AAAA',
      ].each do |validRR|
        it "should not raise an error specified as #{validRR}" do
          expect {
            Puppet::Type.type(:dnsrecord).new(:name => 'test', param => validRR)
            }.to_not raise_error
        end
      end
    end
  end
  
# check to make sure a bullshit params raises an error 
  params = [
  'booya',
  '123',
  ].each do |param|
    context "when param used is #{param}" do
      it "should fail if the resourcetype #{param} is not valid" do
        expect {
          Puppet::Type.type(:dnsrecord).new(:name => 'test', param => 'boooya')
          }.to raise_error
      end
    end
  end

end