class HomeController < ApplicationController

  def index
    @brands = [{:tag => "thinkmeter",:class => "somewhat-popular"},{:tag => "railsrumble",:class => "not-popular"},{:tag => "americanas",:class => "not-popular"},{:tag => "submarino",:class => "not-very-popular"},{:tag => "vizir",:class => "ultra-popular"}]
    @opinions_positives = [{:tag => "#muitobom",:class => "somewhat-popular"},{:tag => "dahora",:class => "not-popular"},{:tag => "dahora",:class => "not-popular"},{:tag => "sensacional",:class => "not-very-popular"},{:tag => "docaralho",:class => "ultra-popular"}]
    @opinions_negatives = [{:tag => "#fail",:class => "somewhat-popular"}]
    @messages = Message.last_messages
  end

end
