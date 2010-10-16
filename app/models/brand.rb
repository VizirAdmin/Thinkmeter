class Brand < ActiveRecord::Base
  has_many :messages_brands
  has_many :brands_opinions
  has_many :messages, :through => :messages_brands
  has_many :opinions, :through => :brands_opinions
  
  INITIAL = 0
  VALID = 1
  INVALID = 2
  named_scope :not_validated, :conditions => 'status = 0'
end
