class CreateOpinions < ActiveRecord::Migration
  def self.up
    create_table :opinions do |t|
      t.string :name
      t.string :expression
      t.integer :classification
      t.string :language_code

      t.timestamps
    end
  end

  def self.down
    drop_table :opinions
  end
end
