require 'spec_helper'

describe Parser::Twitter do
  
  fixtures :opinions, :messages, :brands

  it "should be true" do
    true.should be_true
  end
  
  it "should get nil for a wrong formatted message" do
    brand, opinion = Parser::Twitter.parse messages(:bad_message)
    brand.should be_nil
    opinion.should be_nil
  end
  
  it "should get a brand and opinion for a well formatted message" do
    brand, opinion = Parser::Twitter.parse messages(:good_message)
    brand.should_not be_nil
    opinion.should_not be_nil
  end
  
  it "should sanitize mixed case names" do
    brand, opinion = Parser::Twitter.parse messages(:mixed_case_names)
    brand.should_not be_nil
    opinion.should_not be_nil
    brand.name.should == "mixedcasebrandname"
    opinion.name.should == "preatycool"
  end
  
  it "should sanitize names with special characters" do
    brand, opinion = Parser::Twitter.parse messages(:special_chars_names)
    brand.should_not be_nil
    opinion.should_not be_nil
    brand.name.should == "specialcharsbrandname"
    opinion.name.should == "preatycool"
  end

  it "should sanitize names with accents" do
    brand, opinion = Parser::Twitter.parse messages(:names_with_accents)
    brand.should_not be_nil
    opinion.should_not be_nil
    brand.name.should == "brandwithaccents"
    opinion.name.should == "preatycool"
  end
  
end
