require 'spec_helper'

describe Parser::Twitter do
  
  fixtures :messages

  it "should be true" do
    true.should be_true
  end
  
  it "should parse #ithink message" do
    brand, opinion = Parser::Twitter.parse messages(:valid_ithink_message)
    brand.should_not be_nil
    opinion.should_not be_nil
  end
  
  it "should parse #euacho message" do
    brand, opinion = Parser::Twitter.parse messages(:valid_euacho_message)
    brand.should_not be_nil
    opinion.should_not be_nil
  end
  
  it "should get nil for a wrong formatted message" do
    brand, opinion = Parser::Twitter.parse messages(:invalid_message)
    brand.should be_nil
    opinion.should be_nil
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
  
  it "should get only one world for brand name" do
    brand, opinion = Parser::Twitter.parse messages(:multi_world_opinion)
    brand.name.should == "brandname"
    opinion.name.should == "multi world opinion"
  end
  
  it "should not accept brand names smaller than 2 chars" do
    Parser::Twitter.parse(messages(:small_onechar_brand_name)).should be_nil
  end
  
  it "should not accept monochar brand names with more than 3 characters" do
    Parser::Twitter.parse(messages(:small_monochar_brand_name)).should be_nil
  end
  
  it "should recognize RT messages" do
    brand, opinion = Parser::Twitter.parse messages(:rt_message)
    brand.name.should == "brandname"
    opinion.name.should == "multi world opinion"
  end
    
end
