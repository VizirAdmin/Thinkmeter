class MessagesOpinion < ActiveRecord::Base
  belongs_to :message
  belongs_to :opinion
end
