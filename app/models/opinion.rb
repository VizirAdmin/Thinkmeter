class Opinion < ActiveRecord::Base
  has_many :messages_opinions
  has_many :brands_opinions
  has_many :messages, :through => :messages_opinions
  has_many :brands, :through => :brands_opinions
  has_many :expressions, :dependent => :destroy
  named_scope :unclassified, :conditions => 'classification = -1'

  UNCLASSIFIED = -1
  GOOD = 0
  BAD = 1

  def self.find_all_with_tags(params={})
    Vizir::ActsAsTag.friendly_tags(find_as_tags_with_context(params[:context]))
  end
  
  def self.get_opinion_per_brands(opinion_id)
    result = find_by_sql(["
      SELECT b.name AS name, count(*) AS total FROM opinions o 
      INNER JOIN messages_opinions mo ON o.id = mo.opinion_id
      INNER JOIN messages_brands mb ON mb.message_id = mo.message_id
      INNER JOIN brands b ON b.id = mb.brand_id
      WHERE o.id = ? group by b.name", opinion_id])
    @array = []
    result.each {|r| @array << [r.name,r.total.to_i]}
    @array
  end
  
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
  
private

  def self.find_as_tags_with_context(context)
    find_by_sql(
      "SELECT o.name AS name, count(*) AS total
       FROM opinions o
       INNER JOIN messages_opinions mo ON mo.opinion_id = o.id
       WHERE o.classification = #{context}
       GROUP BY o.name
       ORDER BY total DESC"
      )
  end
end
