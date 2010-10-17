$:.push(File.dirname(__FILE__)+'/../../')

require 'rubygems'
require File.dirname(__FILE__)+'/../../config/environment'

Rails.configuration.log_level = :info # Disable debug
ActiveRecord::Base.allow_concurrency = true

ENV["PATH"] = "/usr/local/bin/:/opt/local/bin:#{ENV["PATH"]}"

namespace :ithink do

  desc "Realiza a busca no Twitter"
  task :search do
    sw=SearchWorker.new
    puts "Buscando novas mensagens no Twitter"
    log=Searchlog.new
    log.date_start = Time.now
    total = sw.add_search_to_database
    log.date_end = Time.now
    log.rc=0
    log.count = total
    log.save
    puts "--> #{total} mensagens encontradas\n\n"
  end
  
  desc "Processa mensagens pendentes"
  task :process do
    puts "Processando novas mensagens"
    n_messages, n_invalid = MessageProcessorWorker.new().perform
    puts "--> #{n_messages} mensagens processadas"
    puts "--> #{n_invalid} mensagens invalidas\n\n"
  end
  
  namespace :reprocess do
    desc "Reprocessa mensagens invalidas"
    task :failed do
      puts "Reprocessando mensagens invalidas"
      Message.update_all("status = 0","status = 3")
      n_messages, n_invalid = MessageProcessorWorker.new().perform
      puts "--> #{n_messages} mensagens processadas"
      puts "--> #{n_invalid} mensagens invalidas\n\n"
    end
    
    task :all do
      puts "Reprocessando todas as mensagens da base de dados"
      Message.update_all("status = 0")
      BrandsOpinion.destroy_all
      MessagesBrand.destroy_all
      MessagesOpinion.destroy_all
      Brand.destroy_all
      Opinion.destroy_all
      n_messages, n_invalid = MessageProcessorWorker.new().perform
      puts "--> #{n_messages} mensagens processadas"
      puts "--> #{n_invalid} mensagens invalidas"
    end
  end

end

