require 'spec_helper'

describe Brand do

  fixtures :brands, :messages_brands

  before(:each) do
    @cleo = brands(:cleopires)
  end

  describe "Brand acts as tags" do
  #unit
    it "should find tags" do
      tags = Brand.find_as_tags
      tags.size.should == 2
      tags[0].name.should == "cleopires"
      tags[0].total.should == "2"
      tags[1].name.should == "locaweb"
      tags[1].total.should == "1"
    end
    it "should show friendly tags" do
      #era para ter mock, mas vai dá trabalho
      tags = Vizir::ActsAsTag.friendly_tags(Brand.find_as_tags)
      tags[0][:tag].should == "cleopires"
      tags[0][:class].should == "not-very-popular"
      tags[1][:tag].should == "locaweb"
      tags[1][:class].should == "not-popular"      
    end

  #integration
    it "should acts as tags" do
      tags = Brand.find_all_with_tags
      tags.size.should == 2
      tags[0][:tag].should == "cleopires"
      tags[0][:class].should == "not-very-popular"
      tags[1][:tag].should == "locaweb"
      tags[1][:class].should == "not-popular"
    end
  end
end
