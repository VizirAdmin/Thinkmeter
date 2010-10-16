class CreateSearches < ActiveRecord::Migration
  def self.up
    create_table :searches do |t|
      t.integer :last_tweet_id
      t.timestamps
    end
    execute("ALTER TABLE searches MODIFY COLUMN last_tweet_id BIGINT NOT NULL")
  end

  def self.down
    drop_table :searches
  end
end

