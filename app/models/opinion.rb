class Opinion < ActiveRecord::Base
  has_many :messages_opinions
  has_many :brands_opinions
  has_many :messages, :through => :messages_opinions
  has_many :brands, :through => :brands_opinions
  has_many :expressions

  UNCLASSIFIED = -1
  GOOD = 0
  BAD = 1

  # def get_expressions()
  #   words=self.name.split(" ")
  #   my_expressions = []
  #   go_into_node(1,words,"",my_expressions)
  #   my_expressions
  # end

  # def go_into_node(i,words,space,arr)
  #   if i==1
  #     go_into_node(i+1,words,words[i-1],arr)
  #     go_into_node(i+1,words,"#{words[i-1]} ",arr)
  #   elsif i==words.size
  #     arr << "#{space}#{words[i-1]}"
  #   else
  #     go_into_node(i+1,words,"#{space}#{words[i-1]}",arr)
  #     go_into_node(i+1,words,"#{space}#{words[i-1]} ",arr)
  #   end
  # end
  
  def add_expression(name)
    self.expressions << Expression.create(:expression => name)
    self.save
    self
  end
  
  def Opinion.find_by_expression(name)
    expression = Expression.find_by_expression(name, :include => [:opinion])
    expression.nil? ? nil : expression.opinion
  end
end
