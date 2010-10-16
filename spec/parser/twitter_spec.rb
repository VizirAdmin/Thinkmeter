require 'spec_helper'

describe Parser::Twitter do
  
  fixtures :opinions, :messages, :brands

  it "should be true" do
    true.should be_true
  end
  
  it "deve retornar [nil,nil] para uma mensagem mal formatada" do
    brand, opinion = Parser::Twitter.parse messages(:bad_message)
    brand.should be_nil
    opinion.should be_nil
  end
  
  it "deve retornar [Brand,Opinion] para uma mensagem bem formatada" do
    brand, opinion = Parser::Twitter.parse messages(:good_message)
    brand.name.should == "railsrumble"
    opinion.name.should == "rocks"
  end
  
end
