require 'spec_helper'

describe MessageProcessorWorker do

  fixtures :opinions, :messages, :brands

  it "process messages with good and bad opinion and brand existent" do
    mpw = MessageProcessorWorker.new()
    mpw.perform
    msgs = Message.find_all_by_status(2)
    msgs.size.should > 1
    cp = Brand.find_by_name("cleopires", :include => [:messages, :opinions])
    cp.opinions.size.should be 1
    cp.opinions[0].classification.should be Opinion::GOOD
    cp.messages.size.should be 1
    
    lb = Brand.find_by_name("locaweb", :include => [:messages, :opinions])
    lb.opinions.size.should be 1
    lb.opinions[0].classification.should be Opinion::BAD
    lb.messages.size.should be 1
  end
  
end
