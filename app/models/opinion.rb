class Opinion < ActiveRecord::Base
  GOOD = 0
  BAD = 1
  has_many :messages, :through => :messages_opinions
  
end
