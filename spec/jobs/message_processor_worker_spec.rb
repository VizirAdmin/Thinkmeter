require 'spec_helper'

describe MessageProcessorWorker do

  fixtures :opinions, :opinions, :messages, :brands

  it "process messages with opinion and brand existent" do
    mpw = MessageProcessorWorker.new()
    mpw.perform
    msgs = Message.find_all_by_status(2)
    msgs.size.should be 2
    cp = Brand.find_by_name("cleo pires", :include => [:messages, :opinions])
    cp.opinions.size.should be 1
    cp.opinions[0].classification.shoulb be Opinion::GOOD
    cp.messages.size.should be 1
    
    lb = Brand.find_by_name("locaweb", :include => [:messages, :opinions])
    lb.opinions.size.should be 1
    lb.opinions[0].classification.shoulb be Opinion::BAD
    lb.messages.size.should be 1
  end
  
end
