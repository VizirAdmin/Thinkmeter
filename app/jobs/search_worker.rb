require 'lib/vizir'

class SearchWorker

  def initialize
    @twitter = Vizir::Twitter.new
  end

  def get_tweets(last_tweet_id)
    @twitter.search("#euacho",last_tweet_id)
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
      add_page_to_database(page)
      page=@twitter.go_to_next_page
    end
    return total
  end

    def add_message_to_database(msg)
    message = Message.create_and_check(:from_user=>msg.from_user, :from_user_id=>msg.from_user_id,
                :geo=>msg.geo, :twitter_id=>msg.id, :language_code=>msg.iso_language_code,
                :profile_img_url=>msg.profile_image_url, :source =>msg.source,
                :text=>msg.text, :to_user_id=>msg.to_user_id, :created_at=>msg.created_at,
                :recent_retweets =>msg.metadata.recent_retweets, :result_type=>msg.metadata.result_type,
                :status => 0)
   end

  def add_page_to_database(page)
    page.each do |msg|
      db_msg  =  add_message_to_database(msg)
    end
  end

end

