class CreateMessages < ActiveRecord::Migration
  def self.up
    create_table :messages do |t|
      t.string :from_user
      t.integer :from_user_id
      t.string :geo
      t.integer :twitter_id
      t.string :language_code
      t.string :profile_img_url
      t.string :source
      t.string :text
      t.string :to_user
      t.integer :to_user_id
      t.integer :status, :default => -1
      t.datetime :created_at
      t.integer :recent_retweets
      t.string :result_type
      t.timestamps
    end
    execute("ALTER TABLE messages MODIFY COLUMN twitter_id BIGINT NOT NULL")
    t.timestamps
    end
  end

  def self.down
    drop_table :messages
  end
end

