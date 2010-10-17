require 'lib/parser/twitter'

class MessageProcessorWorker

  def perform
    Message.update_all("status = 1","status = 0")
    messages = Message.find_all_by_status(1)
    invalid_message_counter = 0
    
    messages.each do |message|
      begin
        process_message(message)
        invalid_message_counter += 1 if message.status == Message::ERROR
        
      rescue Exception => e
        puts "Error processing message: \"#{message.text}\", error: #{e}"
        message.status = Message::ERROR
        message.save
      end
    end
    
    [messages.size, invalid_message_counter]
  end

  def process_message(message)
    brand, opinion = Parser::Twitter.parse(message)

    if opinion && brand
      opinion.messages << message
      opinion.save
      
      brand.opinions << opinion
      brand.messages << message
      brand.save
      
      message.status = Message::PROCESSED
      #opinion.save
      #associate_opinion_to_brand(message, brand, opinion)
    else
      message.status = Message::ERROR
      #message.trashed = 1
    end
    
    message.save
  end
  
  # def associate_opinion_to_brand(message, brand, opinion)
  #   MessagesBrand.create(:message_id => message.id, :brand_id => brand.id)
  #   MessagesOpinion.create(:message_id => message.id, :opinion_id => opinion.id)
  #   BrandsOpinion.create(:brand_id => brand.id, :opinion_id => opinion.id)
  # end
end
