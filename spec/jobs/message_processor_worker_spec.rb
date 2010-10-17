require 'spec_helper'

describe MessageProcessorWorker do

  fixtures :opinions, :expressions, :messages, :brands

  it "process messages with good and bad opinion and brand existent" do
    mpw = MessageProcessorWorker.new()
    mpw.perform
    msgs = Message.find_all_by_status(3)
    msgs = Message.find_all_by_status(2)
    msgs.size.should > 1
    cp = Brand.find_by_name("cleopires", :include => [:messages, :opinions])
    cp.opinions.size.should be 3
    cp.opinions[0].classification.should be Opinion::GOOD
    cp.messages.size.should be 5
    
    lb = Brand.find_by_name("locaweb", :include => [:messages, :opinions])
    lb.opinions.size.should be 1
    lb.opinions[0].classification.should be Opinion::BAD
    lb.messages.size.should be 2
  end
  
  it "process messages verify with non existent brands and opinions, and check if it's generated in the DB" do
    mpw = MessageProcessorWorker.new()
    mpw.perform
    b = Brand.find_by_name("patata")
    b.should_not be_nil
    #b.status.should be Brand::INVALID
    o = Opinion.find_by_name("uma desgraca", :include => [:expressions])
    o.nil?.should be false
    o.classification.should be Opinion::UNCLASSIFIED
    o.expressions[0].expression.should == "uma desgraca"
  end
end
