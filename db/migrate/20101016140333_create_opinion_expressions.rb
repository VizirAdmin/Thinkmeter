class CreateOpinionExpressions < ActiveRecord::Migration
  def self.up
    create_table :opinion_expressions do |t|
      t.integer :opinion_id
      t.string :expression

      t.timestamps
    end
  end

  def self.down
    drop_table :opinion_expressions
  end
end
