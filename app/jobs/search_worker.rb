require 'lib/vizir'

class SearchWorker

  def initialize
    @twitter = Vizir::Twitter.new
  end

  def get_tweets(last_tweet_id)
    @twitter.search("#IThink")
  end

  def add_search_to_database
    search = Search.first
    page = get_tweets(search.last_tweet_id)
    total = 0
    if (!page.nil?) && (!page.first.nil?)
      search.last_tweet_id = page.first.id
      search.save
    end
    while !page.nil? and page.size>0 do
      total += page.size
#      add_page_to_database(page).each do |r|

#      end
      page=@twitter.go_to_next_page
    end
    return total
  end



end

