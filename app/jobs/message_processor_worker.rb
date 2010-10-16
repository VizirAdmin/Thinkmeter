class MessageProcessorWorker
  
  def perform
    Message.update_all("status = 1","status = 0")
    messages = Message.find_all_by_status(1)
    messages.each do |message|
      begin
        brand, opinion = Interpretor.interpret(message)
        if(!opinion.nil? && !brand.nil?)
          associate_opinion_to_brand(mesage, brand, opinion)
        elsif(!opinion.nil?)
          
        else
        
        end
      rescue
        message.status = 3
        message.save
      end      
    end
    Message.update_all("status = 2","status = 1")
  end
  
  def associate_opinion_to_brand(mesage, brand, opinion)
    MessagesBrand.create(:message_id => message.id, :brand_id => brand.id)
    MessagesOpinion.create(:message_id => message.id, :opinion_id => opinion.id)
  end
end
