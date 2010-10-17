class Brand < ActiveRecord::Base
  has_many :messages_brands
  has_many :brands_opinions
  has_many :messages, :through => :messages_brands
  has_many :opinions, :through => :brands_opinions

  INITIAL = 0
  VALID = 1
  INVALID = 2
  named_scope :not_validated, :conditions => 'status = 0'
  named_scope :validated, :conditions => 'status = 1'  
  def self.find_all_with_tags
    Vizir::ActsAsTag.friendly_tags(find_as_tags)
  end

private

  def self.find_as_tags
    find_by_sql(
      "SELECT b.id AS id, b.name AS name, count(*) AS total
       FROM brands b
       INNER JOIN messages_brands mb ON mb.brand_id = b.id
       WHERE status = 1
       GROUP BY b.name
       ORDER BY total DESC"
      )
  end

  def self.get_brand_per_opinions(brand_id)
    result = find_by_sql(["
      SELECT o.name AS name, count(*) AS total FROM opinions o
      INNER JOIN messages_opinions mo ON o.id = mo.opinion_id
      INNER JOIN messages_brands mb ON mb.message_id = mo.message_id
      INNER JOIN brands b ON b.id = mb.brand_id
      WHERE b.id = ? group by o.name
      ORDER BY total", brand_id])
    @array = []
    result.each {|r|
    @array << [r.name,r.total.to_i]
    }
    @array
  end


end

