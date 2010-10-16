class Brand < ActiveRecord::Base
  has_many :messages_brands
  has_many :brands_opinions
  has_many :messages, :through => :messages_brands
  has_many :opinions, :through => :brands_opinions
  
  INITIAL = 0
  VALID = 1
  INVALID = 2
  named_scope :not_validated, :conditions => 'status = 0'
    
  def self.find_all_with_tags
    Vizir::ActsAsTag.friendly_tags(find_as_tags)
  end

private

  def self.find_as_tags
    find_by_sql(
      "SELECT b.name AS name, count(*) AS total
       FROM brands b
       INNER JOIN messages_brands mb ON mb.brand_id = b.id
       GROUP BY b.name
       ORDER BY total DESC"
      )
  end
  
end
