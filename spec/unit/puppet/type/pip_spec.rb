#!/usr/bin/env ruby

require 'puppet'

pip = Puppet::Type.type(:pip).new(:name => "yoda")

describe pip do
  it "should stringify normally" do
    pip.to_s.should == "Pip[yoda]"
  end
end
