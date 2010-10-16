require 'spec_helper'

describe Parser::Twitter do

  it "should be true" do
    true.should be_true
  end
  
  it "deve retornar [nil,nil] ao parsear uma mensagem mal formatada" do
    message = Message.create(
      :twitter_id => 123456,
      :text => "I need me a lil boo...#ithink*** yes!"
    )
    brand, opinion = Parser::Twitter.parse(message)
    brand.should be_nil
    opinion.should be_nil
  end
  
  it "deve retornar [Brand,Opinion] para uma mensagem bem formatada" do
    message = Message.create(
      :twitter_id => 123456,
      :text => "#ithink railsrumble rocks"
    )
    brand, opinion = Parser::Twitter.parse(message)
    brand.name.should be "railsrumble"
    opinion.name.shoud be "rocks"
    
  end
  
end
