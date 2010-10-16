require 'spec_helper'

describe SearchWorker do

  fixtures :searches

  before(:each) do
    @search = searches(:search)
  end
  it "get_tweets" do
    @search.last_tweet_id=2
    @search.save
    s = SearchWorker.new()
    result = s.get_tweets(1)
    result.size.should > 0
    result.first.id.should > 0
  end

  it "adicionar todos os tweets no banco - busca maior" do
    @search.last_tweet_id=3
    @search.save
    s = SearchWorker.new()
    result_size = s.add_search_to_database()
    Message.all.size.should == result_size
  end

end

