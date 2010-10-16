class AddUniqueIndexTwitterIdOnMessages < ActiveRecord::Migration
  def self.up
    add_index :messages, :twitter_id, :unique => true
  end

  def self.down
  end
end

