class Message < ActiveRecord::Base

  def before_create
    m = Message.first :conditions => ["twitter_id = ?", self.twitter_id]
    m.nil?
  end

  def self.create_and_check(create_params)
    m = create(create_params)
    if m.id.nil?
      m = Message.first :conditions => ["twitter_id = ?", create_params[:twitter_id]]
    end
    m
  end


end

