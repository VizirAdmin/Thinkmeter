require 'lib/parser/twitter'

class MessageProcessorWorker

  def perform
    Message.update_all("status = 1","status = 0")
    messages = Message.find_all_by_status(1)
    messages.each do |message|
#      begin
        brand, opinion = Parser::Twitter.parse(message)
        if(!opinion.nil? && !brand.nil?)
          associate_opinion_to_brand(message, brand, opinion)
        else
          puts "opinion and brand invalids"
        end
 #     rescue
  #      message.status = 3
   #     message.save
    #  end   
    end
    Message.update_all("status = 2","status = 1")
  end
  
  def associate_opinion_to_brand(message, brand, opinion)
    MessagesBrand.create(:message_id => message.id, :brand_id => brand.id)
    MessagesOpinion.create(:message_id => message.id, :opinion_id => opinion.id)
    BrandsOpinion.create(:brand_id => brand.id, :opinion_id => opinion.id)
  end
end
