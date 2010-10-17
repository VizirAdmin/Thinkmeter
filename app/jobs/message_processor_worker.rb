require 'lib/parser/twitter'

class MessageProcessorWorker

  def perform
    Message.update_all("status = 1","status = 0")
    messages = Message.find_all_by_status(1)
    
    messages.each do |message|
      begin
        process_message(message)
      rescue Exception => e
        puts "Error processing message: \"#{message.text}\", error: #{e}"
        message.status = Message::ERROR
        message.save
      end
    end
    
    Message.update_all("status = 2","status = 1")
    messages.size
  end

  def process_message(message)
    brand, opinion = Parser::Twitter.parse(message)
    if opinion && brand
      opinion.messages << message
      opinion.save
      
      brand.opinions << opinion
      brand.messages << message
      brand.save
      
      #opinion.save
      #associate_opinion_to_brand(message, brand, opinion)
    else
      puts "Invalid message: \"#{message.text}\" (brand: #{brand}, opinion: #{opinion})"
      message.status = Message::ERROR
      #message.trashed = 1
      message.save
    end
  end
  
  # def associate_opinion_to_brand(message, brand, opinion)
  #   MessagesBrand.create(:message_id => message.id, :brand_id => brand.id)
  #   MessagesOpinion.create(:message_id => message.id, :opinion_id => opinion.id)
  #   BrandsOpinion.create(:brand_id => brand.id, :opinion_id => opinion.id)
  # end
end
