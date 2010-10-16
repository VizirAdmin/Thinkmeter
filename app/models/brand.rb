class Brand < ActiveRecord::Base
  has_many :messages_brands
  has_many :brands_opinions
  has_many :messages, :through => :messages_brands
  has_many :opinions, :through => :brands_opinions
end
