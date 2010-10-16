class CreateSearchlogs < ActiveRecord::Migration
  def self.up
    create_table :searchlogs do |t|
      t.datetime :date_start
      t.datetime :date_end
      t.integer :count
      t.integer :rc
      t.timestamps
    end
  end

  def self.down
    drop_table :searchlogs
  end
end

class CreateTasklog < ActiveRecord::Migration
  def self.up
    create_table :tasklogs do |t|
      t.datetime :date_start
      t.datetime :date_end
      t.integer :rc
      t.integer :info
      t.string :message
      t.string :prefix
      t.string :item_identification
      t.timestamps
    end
  end

  def self.down
    drop_table :tasklog
  end
end

