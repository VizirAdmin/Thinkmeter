class HomeController < ApplicationController

  def index
    @brands = Brand.find_all_with_tags
    @opinions_positives = [{:tag => "#muitobom",:class => "somewhat-popular"},{:tag => "dahora",:class => "not-popular"},{:tag => "dahora",:class => "not-popular"},{:tag => "sensacional",:class => "not-very-popular"},{:tag => "docaralho",:class => "ultra-popular"}]
    @opinions_negatives = [{:tag => "#fail",:class => "somewhat-popular"}]
    @messages = Message.last_messages
    @tweet_count=Message.count
    @brand_count=Brand.count
    @opinion_count=Opinion.count

  end

end

