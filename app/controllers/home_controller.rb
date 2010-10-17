class HomeController < ApplicationController

  def index
    @brands = Brand.find_all_with_tags
    @brand_name = @brands[rand(@brands.size)][:tag] if !@brands.empty?
    @opinions_positives = Opinion.find_all_with_tags(:context => Opinion::GOOD)
    @opinions_negatives = Opinion.find_all_with_tags(:context => Opinion::BAD)
    @messages = Message.last_messages
    @tweet_count=Message.count
    @brand_count=Brand.validated.count
    @opinion_count=Opinion.validated.count
    @positive_chart_height = Opinion.calc_height(@opinion_count, Opinion.good.count)
    @negative_chart_height = Opinion.calc_height(@opinion_count, Opinion.bad.count)
  end

end

