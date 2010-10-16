class CreateMessagesOpinions < ActiveRecord::Migration
  def self.up
    create_table :messages_opinions do |t|
      t.integer :message_id
      t.integer :opinion_id

      t.timestamps
    end
  end

  def self.down
    drop_table :messages_opinions
  end
end
