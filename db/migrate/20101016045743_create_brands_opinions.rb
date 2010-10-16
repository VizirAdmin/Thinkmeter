class CreateBrandsOpinions < ActiveRecord::Migration
  def self.up
    create_table :brands_opinions do |t|
      t.integer :brand_id
      t.integer :opinion_id

      t.timestamps
    end
  end

  def self.down
    drop_table :brands_opinions
  end
end
