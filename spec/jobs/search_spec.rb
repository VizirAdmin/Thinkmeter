require 'spec_helper'

describe SearchWorker do

  fixtures :brands, :expressions, :searches

  it "get_tweets passando search que existe" do
    s = SearchWorker.new()
    result = s.get_tweets(0)
    result.size.should > 0
    result.first.id.should > 0
  end

#  it "adicionar tweets no banco" do
#    result = @search_worker.get_tweets(@search_vizir)
#    @search_worker.add_page_to_database(@search_vizir,result)
#    @search_vizir.messages.size.should == result.size
#  end

#  it "adicionar todos os tweets no banco - busca maior" do
#    result_size,z,y = @search_worker.add_search_to_database(@search_cheia)
#    @search_cheia.messages.size.should == result_size
#  end

#  it "adicionar todos os tweets no banco e seta o last_tweet_id - busca menor" do
#    result_size,last_tweet_id,z = @search_worker.add_search_to_database(@search_vizir)
#    @search_vizir.messages.size.should == result_size
#    @search_vizir.last_tweet_id.should == last_tweet_id
#  end

#  it "checagem se respeita o last_tweet_id" do
#    first_result_size,first_last_tweet_id,z = @search_worker.add_search_to_database(@search_cheia)
#    result = @search_worker.get_tweets(@search_cheia)
#    first_last_tweet_id.should be < result.first.id
#  end

#  it "nao pode ter duas mensagens com o mesmo tweet Id na base de dados" do
#    first_result_size,first_last_tweet_id,z = @search_worker.add_search_to_database(@search_vizir)
#    sleep 3 #Este timeout pq o Twitter da erro em Requests iguais
#    second_result_size,second_last_tweet_id,z = @search_worker.add_search_to_database(@search_vizir_2)
#    x = ActiveRecord::Base.connection().select_one("select count(*) as ct,twitter_id from messages group by twitter_id having ct > 1")
#    x.should == nil;
#  end

  it "nao pode adicionar duas mensagens para o mesmo search na base de dados" do
    ActiveRecord::Base.connection().execute ("delete from messages")
    first_result_size,first_last_tweet_id,z = @search_worker.add_search_to_database(@search_vizir)
    sleep 5 #Este timeout pq o Twitter da erro em Requests iguais
    puts "Retornou:#{first_result_size}"
    @search_vizir.last_tweet_id = 0
    @search_vizir.save
    second_result_size,second_last_tweet_id,z = @search_worker.add_search_to_database(@search_vizir)
    puts "Retornou:#{second_result_size}"
    x = ActiveRecord::Base.connection().select_one("select count(*) as ct,twitter_id from messages group by twitter_id having ct > 1")
    x.should == nil;
    x = ActiveRecord::Base.connection().select_one("select count(*) as ct,message_id from messages_searches group by message_id having ct > 1")
    x.should == nil;
    Message.all.size == second_result_size;
  end


end

