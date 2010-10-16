require 'lib/vizir'

class SearchWorker

  def initialize
    @twitter = Vizir::Twitter.new
  end

  def get_tweets(last_tweet_id)
    @twitter.search("#IThink")
  end

end

