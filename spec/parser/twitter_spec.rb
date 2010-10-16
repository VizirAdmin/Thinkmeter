require 'spec_helper'

describe Parser::Twitter do
  
  fixtures :opinions, :messages, :brands

  it "should be true" do
    true.should be_true
  end
  
  it "should get [nil,nil] for a wrong formatted message" do
    brand, opinion = Parser::Twitter.parse messages(:bad_message)
    brand.should be_nil
    opinion.should be_nil
  end
  
  it "should get [Brand,Opinion] for a well formatted message" do
    brand, opinion = Parser::Twitter.parse messages(:good_message)
    brand.should_not be_nil
    opinion.should_not be_nil
  end
  
end
