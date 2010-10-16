module Parser
  class Twitter
    # TODO parametrizar ou aceitar varios tokens: #ithink, #euacho etc
    REGEXP = /^.*\#ithink ([\#\@a-zA-Z0-9]+) (.*)/
    
    def Twitter.parse(message)
      match = REGEXP.match(message.text)
      if !match.nil?
        return find_brand_by_name(match[1]), find_opinion_by_expression(match[2])
      else
        return nil, nil
      end
    end
    
private
    def Twitter.find_brand_by_name(name)
      brand = Brand.find_by_name(name)
      brand = Brand.new(
        :name => name, 
        :site => "", 
        :description => "", 
        :twitter_profile => "", 
        :status => Brand::INVALID
      ) if !brand
      
      brand
    end
    
    def Twitter.find_opinion_by_expression(expression)
      opinion = Opinion.find_by_expression expression
      
      if !opinion
        opinion = Opinion.new(
          :name => expression,
          :language_code => "", 
          :classification => Opinion::UNCLASSIFIED
        )
      else
        opinion = opexp.opinion
      end
      
      opinion
    end
  end
  
end
