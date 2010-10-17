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
    puts "Vai procurar no Twitter"
    log=Searchlog.new
    log.date_start = Time.now
    total = sw.add_search_to_database
    log.date_end = Time.now
    log.rc=0
    log.count = total
    log.save
    puts "Encontrou #{total} registros"
  end
  
  desc "Processa mensagens pendentes"
  task :process do
    MessageProcessorWorker.new().perform
  end

end

