class MessageProcessorWorker
  
  def perform
    Message.update_all("status = 1","status = 0")
    messages = Message.find_all_by_status(1)
    messages.each do |message|
      begin
        brand, opinion = Interpretor.interpret(message)
        if(!opinion.nil?)
          associate_opinion_to_brand(mesage, brand, opinion)
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
    
  end
end
