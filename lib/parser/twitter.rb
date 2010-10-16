module Parser
  class Twitter
    # TODO parametrizar ou aceitar varios tokens: #ithink, #euacho etc
    REGEXP = /^.*\#ithink ([\#\@a-zA-Z0-9]+) (.*)/
    
    def Twitter.parse(message)
      match = REGEXP.match(message.text)
      if !match.nil?
        return get_brand(match[1]), get_opinion(match[2])
      else
        return nil, nil
      end
    end
    
private
    def Twitter.get_brand(name)
      brand = Brand.find_by_name(name)
      brand = Brand.create(:name => name, :site => "", :description => "", :twitter_profile => "", :status => Brand::INVALID) if brand.nil?
      brand
    end
    
    def Twitter.get_opinion(expression)
      opexp = Expression.find_by_expression(expression, :include => [:opinion])
      if(opexp.nil?)      
        opinion = Opinion.create(:name => expression, :language_code => "", :classification => Opinion::UNCLASSIFIED)
        opinion.expressions.create(:expression => expression)
      else
        opinion = opexp.opinion
      end
      opinion
    end
  end
  
end
