require 'spec_helper'

describe Opinion do

  it "should be true" do
    true.should be_true
  end
  
  before(:each) do
  end
  
  it "deve criar uma opinião com varias expressões" do
    opinion = Opinion.new(:name => "legal")
    opinion.add_expression "bem legal"
    opinion.add_expression "bemlegal"
    opinion.save
  end
  
  it "deve encontrar uma opinião dada uma expressao" do
    
  end

end
