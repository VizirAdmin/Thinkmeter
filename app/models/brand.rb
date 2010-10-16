class Brand < ActiveRecord::Base
  has_many :messages, :through => :messages_brands
  has_many :opinions, :through => :brands_opinion
end
