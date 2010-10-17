class Opinion < ActiveRecord::Base
  
  # Classification constants
  UNCLASSIFIED = -1
  GOOD         = 0
  BAD          = 1
  
  has_many :messages_opinions
  has_many :brands_opinions
  has_many :messages, :through => :messages_opinions
  has_many :brands, :through => :brands_opinions
  has_many :expressions, :dependent => :destroy
  
  named_scope :unclassified, :conditions => "classification = #{Opinion::UNCLASSIFIED}"
  named_scope :good, :conditions => "classification = #{Opinion::GOOD}"
  named_scope :bad, :conditions => "classification = #{Opinion::BAD}"
  named_scope :validated, :conditions => "classification in (#{Opinion::GOOD},#{Opinion::GOOD})"

  def self.total_of_brands_with_me(brand_id)
    find_by_sql(["
      SELECT count(*) AS count FROM opinions o
      INNER JOIN messages_opinions mo ON mo.opinion_id = o.id
      INNER JOIN messages_brands mb ON mb.message_id = mo.message_id
      WHERE o.id = ?",brand_id
      ])
  end

  def self.calc_height(total, opinions)
    if total > 0;(opinions * 400) / total; else; 200; end
  end

  def self.find_all_with_tags(params={})
    Vizir::ActsAsTag.friendly_tags(find_as_tags_with_context(params[:context]))
  end

  def self.find_all_with_tags_by_brand(params={})
    Vizir::ActsAsTag.friendly_tags(find_as_tags_by_brand(params[:context]))
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
      "SELECT o.id AS id, o.name AS name, count(*) AS total
       FROM opinions o
       INNER JOIN messages_opinions mo ON mo.opinion_id = o.id
       WHERE o.classification = #{context}
       GROUP BY o.name
       ORDER BY total DESC"
      )
  end

    def self.find_as_tags_by_brand(brand_id)
    find_by_sql(
      "SELECT o.id AS id, o.name AS name, count(*) AS total
       FROM opinions o
       INNER JOIN messages_opinions mo ON mo.opinion_id = o.id
       INNER JOIN messages_brands mb on mb.message_id = mo.message_id
       WHERE mb.brand_id = #{brand_id}
       GROUP BY o.name
       ORDER BY total DESC"
      )
    end

end

