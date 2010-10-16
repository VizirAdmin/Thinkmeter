
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
      total = sw.add_search_to_database
      puts "Encontrou #{total} registros"
    end
  end

