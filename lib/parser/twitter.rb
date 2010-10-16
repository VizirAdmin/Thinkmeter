module Parser
  
  class Twitter
    # TODO parametrizar ou aceitar varios tokens: #ithink, #euacho etc
    REGEXP = /^.*\#ithink ([a-zA-Z0-9áàãâéèêíìîòóõôùúçÁÀÃÂÉÈÊÍÌÎÒÓÕÔÙÚÇ\`\~\!\@\#\$\%\^\&\*\(\)\-\_\+\=\{\}\'\<\>\?\/]+) (.*)/
    
    # This characters will be removed from Brand and Option names
    SPECIAL_CHARS_REMOVE = ["&","?"]
    
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
      brand = Brand.find_by_name(sanitize(name))
      brand = Brand.new(
        :name => sanitize(name),
        :site => "", 
        :description => "", 
        :twitter_profile => "", 
        :status => Brand::INVALID
      ) if !brand
      
      brand
    end
    
    def Twitter.find_opinion_by_expression(expression)
      opinion = Opinion.find_by_name(sanitize(expression))
      opinion = Opinion.find_by_expression(expression) if opinion.nil?
      
      if !opinion
        opinion = Opinion.new(
          :name => sanitize(expression),
          :language_code => "",
          :classification => Opinion::UNCLASSIFIED
        )
        opinion.add_expression(expression)
      end
      
      opinion
    end
    
    def Twitter.sanitize(name)
      name.downcase!
      SPECIAL_CHARS_REMOVE.each do |char|
        name.sub!(char,"")
      end
      name.remover_acentos!
      name
    end
    
  end
  
end
