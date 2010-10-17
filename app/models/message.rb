class Message < ActiveRecord::Base
  has_many :messages_brands
  has_many :messages_opinions
  has_many :brands, :through => :messages_brands
  has_many :opinions, :through => :messages_opinions

  NOT_PROCESSED = 0
  PROCESSING = 1
  PROCESSED = 2
  ERROR = 3

  named_scope :positives, :conditions => "o.classification = #{Opinion::GOOD} and messages.status >= 0",
      :joins => "INNER JOIN messages_opinions mo ON mo.message_id = messages.id
                 INNER JOIN opinions o ON o.id = mo.opinion_id"
  named_scope :negatives, :conditions => "o.classification = #{Opinion::BAD} and messages.status >= 0",
      :joins => "INNER JOIN messages_opinions mo ON mo.message_id = messages.id
                 INNER JOIN opinions o ON o.id = mo.opinion_id"

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

  def self.last_messages(params={})
    params = {:quantity => 20}.merge(params)
    all(:conditions=>"messages.status = #{Message::PROCESSED}",:limit=> params[:quantity], :order => "created_at DESC")
  end
end

