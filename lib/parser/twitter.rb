module Parser
  
  class Twitter
    REGEXP = /^\#(ithink|euacho) ([a-zA-Z0-9áàãâéèêíìîòóõôùúçÁÀÃÂÉÈÊÍÌÎÒÓÕÔÙÚÇ\@][a-zA-Z0-9áàãâéèêíìîòóõôùúçÁÀÃÂÉÈÊÍÌÎÒÓÕÔÙÚÇ\`\~\!\@\#\$\%\^\&\*\(\)\-\_\+\=\{\}\'\<\>\?\/]+) (.*)/
    
    # This characters will be removed from Brand and Option names
    SPECIAL_CHARS_REMOVE = ["&","?"]
    
    def Twitter.parse(message)
      match = REGEXP.match(message.text)
      if match
        brand = find_brand_by_name(match[2])
        opinion = find_opinion_by_expression(match[3])
        return (brand && opinion ? [brand,opinion] : nil)
      else
        return nil
      end
    end
    
private
    def self.find_brand_by_name(name)
      brand = Brand.find_by_name(sanitize(name))
      brand = Brand.new(
        :name => sanitize(name),
        :site => "", 
        :description => "", 
        :twitter_profile => "", 
        :status => Brand::INITIAL
      ) if !brand && valid_brand_name?(sanitize(name))
      
      brand
    end
    
    def self.valid_brand_name?(name)
      name.size > 2 &&
      (name.size > 3 ? !Regexp.new("^#{name.first}+$").match(name) : true)
    end
    
    def self.find_opinion_by_expression(expression)
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
        name.gsub!(char,"")
      end
      name.remover_acentos!
      name
    end
    
  end
  
end
