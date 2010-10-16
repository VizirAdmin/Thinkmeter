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
      brand = Brand.create(:name => name) if brand.nil?
      brand
    end
    
    def Twitter.get_opinion(expression)
      opinion = Opinion.find_by_name(expression)
      opinion = Opinion.create(:name => expression) if opinion.nil?
      opinion
    end
  end
  
end
