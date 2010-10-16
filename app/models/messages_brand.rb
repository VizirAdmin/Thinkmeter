class MessagesBrand < ActiveRecord::Base
  belongs_to :message
  belongs_to :brand
end
