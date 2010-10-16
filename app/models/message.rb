class Message < ActiveRecord::Base
  NOT_PROCESSED = 0
  PROCESSING = 1
  PROCESSED = 2
  ERROR = 3

  def before_create
    m = Message.first :conditions => ["twitter_id = ?", self.twitter_id]
    if m.nil?
      self.html_text=check_text_for_urls
    end
    m.nil?
  end

  def self.create_and_check(create_params)
    m = create(create_params)
    if m.id.nil?
      m = Message.first :conditions => ["twitter_id = ?", create_params[:twitter_id]]
    end
    m
  end

  def check_text_for_urls
    self.text.gsub(/(http:\/\/[A-Za-z0-9\.\/\-\%\?\&_]+)/, '<a href="\1" target="blank">\1</a>').gsub(/@([A-Za-z0-9_]+)/, '<a href="http://twitter.com/\1" target="blank">@\1</a>').gsub(/#([A-Za-z0-9_]+)/, '<a href="http://search.twitter.com/search?q=#\1" target="blank">#\1</a>')
  end

end

