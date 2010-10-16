require 'spec_helper'

describe Opinion do

  fixtures :opinions, :messages_opinions

  describe "Opinion acts as tags" do
  #unit
    it "should find tags in positive context" do
      tags = Opinion.find_as_tags_with_context(Opinion::GOOD)
      puts tags.inspect
      tags.size.should == 3
      tags[0].name.should == "uma delicia"
      tags[0].total.should == "2"
      tags[1].name.should == "gostosa pra cacete"
      tags[1].total.should == "1"
      tags[2].name.should == "rocks"
      tags[2].total.should == "1"
    end

    it "should find tags in negative context" do
      tags = Opinion.find_as_tags_with_context(Opinion::BAD)
      tags.size.should == 1
      tags[0].name.should == "uma bosta"
      tags[0].total.should == "1"
    end
  end
end
