class HomeController < ApplicationController

  def index
    @brands = Brand.find_all_with_tags
    @opinions_positives = Opinion.find_all_with_tags(:context => Opinion::GOOD)
    @opinions_negatives = Opinion.find_all_with_tags(:context => Opinion::BAD)
    @messages = Message.last_messages
    @tweet_count=Message.count
    @brand_count=Brand.count
    @opinion_count=Opinion.count

  end

end

