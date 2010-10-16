class CreateBrands < ActiveRecord::Migration
  def self.up
    create_table :brands do |t|
      t.string :name
      t.string :site
      t.string :description
      t.string :twitter_profile

      t.timestamps
    end
  end

  def self.down
    drop_table :brands
  end
end
