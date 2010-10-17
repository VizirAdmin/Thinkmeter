class HomeController < ApplicationController

  def index
    @brands = Brand.find_all_with_tags
    @brand_name = if @brands.size > 0; @brands[rand(@brands.size)][:tag]; else; "ThinkMeter"; end
    @opinions_positives = Opinion.find_all_with_tags(:context => Opinion::GOOD)
    @opinions_negatives = Opinion.find_all_with_tags(:context => Opinion::BAD)
    @messages = Message.last_messages
    @tweet_count=Message.count
    @brand_count=Brand.validated.count
    @opinion_count=Opinion.validated.count
    @positive_chart_height = Opinion.calc_height(@opinion_count, Opinion.good.count)
    @negative_chart_height = Opinion.calc_height(@opinion_count, Opinion.bad.count)
    Rails.logger.info "*" * 100
    Rails.logger.info    @opinion_count
    Rails.logger.info Opinion.good.count
    Rails.logger.info Opinion.bad.count
    Rails.logger.info "*" * 100
  end

  def help
    render "help"
  end
end

