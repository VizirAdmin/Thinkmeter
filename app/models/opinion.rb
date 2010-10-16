class Opinion < ActiveRecord::Base
  has_many :messages_opinions
  has_many :brands_opinions
  has_many :messages, :through => :messages_opinions
  has_many :brands, :through => :brands_opinions

  UNCLASSIFIED = -1
  GOOD = 0
  BAD = 1

end
