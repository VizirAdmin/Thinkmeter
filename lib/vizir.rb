module Vizir
  class Twitter
    @next_page_url, @last_query = "",""
    def search(search_string, last_tweet_id)
      result = Restfulie.at("http://search.twitter.com/search.json").accepts("application/json").get(:q=>search_string,:rpp=>"100", :since_id=>"#{last_tweet_id}")
      @last_query=search_string
      set_next_page_and_results(result)
    end

    def set_next_page_and_results(result)
      if result.class==Array
        @next_page_url=nil
        nil
      else
        @next_page_url = result.next_page
        result.results
      end
    end

    def go_to_next_page
      if @next_page_url.nil? || @next_page_url.class==Array
        nil
      else
        result = Restfulie.at("http://search.twitter.com/search.json").accepts("application/json").get(build_params(@next_page_url[1..-1],@last_query,"100"))
        set_next_page_and_results(result)
      end
    end

    def get_twitter_profile(profile)
      Restfulie.at("http://api.twitter.com/1/users/show/#{profile}").accepts("application/json").get()
    end

private
    def build_params(next_page,query,rpp)
      hash_params = {}
      params = next_page.split("&")
      params.each do |p|
        op = p.split("=")
        hash_params[op[0]]=op[1]
      end
      hash_params["q"]=query
      hash_params["rpp"]=rpp
      hash_params
    end
  end

  class ActsAsTag
    
    def self.friendly_tags(tags)
      array = []
      tags.each {|tag| array << {:tag => tag.name,:class => tag_class(tag.total.to_i)}}
      array
    end
    
    def self.tag_class(total)
       @divisor ||= total.div 6
       result = if @divisor > 6; total.div @divisor; else; total; end
       case result
         when 1
           "not-popular"
         when 2
           "not-very-popular"
         when 3
           "somewhat-popular"
         when 4
           "popular"
         when 5
           "very-popular"
         when 6
           "ultra-popular"
       end
    end
  end

end

