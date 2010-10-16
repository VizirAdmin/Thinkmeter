class CreateMessagesBrands < ActiveRecord::Migration
  def self.up
    create_table :messages_brands do |t|
      t.integer :message_id
      t.integer :brand_id

      t.timestamps
    end
  end

  def self.down
    drop_table :messages_brands
  end
end
