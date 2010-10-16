module Parser
  class Twitter
    # TODO parametrizar ou aceitar varios tokens: #ithink, #euacho etc
    REGEXP = /^\#ithink ([\#\@a-zA-Z0-9]+) (.*)/
    
    def Twitter.parse(message)
      match = REGEXP.match(message.text)
      if !match.nil?
        name, expression = [match[1], match[2]]
        [get_brand(name), get_opinion(expression)]
      else
        [nil,nil]
      end
    end
    
private
    def Twitter.get_brand(name)
      brand_name = name if name
      brand = Brand.find_by_name(name)
      brand = Brand.create(:name => name) if brand.nil?
    end
    
    def Twitter.get_opinion(expression)
      opinion = Opinion.find_by_name(expression)
      opinion = Opinion.create(:name => expression) if opinion.nil?
    end
  end
  
end