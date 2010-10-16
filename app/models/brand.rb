class Brand < ActiveRecord::Base
  has_many :messages, :through => :messages_brands
end
