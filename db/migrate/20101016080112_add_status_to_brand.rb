class AddStatusToBrand < ActiveRecord::Migration
  def self.up
    add_column :brands, :status, :integer
  end

  def self.down
   remove_column :brands, :status
  end
end
