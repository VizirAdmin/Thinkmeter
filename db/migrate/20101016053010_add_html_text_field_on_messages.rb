class AddHtmlTextFieldOnMessages < ActiveRecord::Migration
  def self.up
    add_column :messages, :html_text, :text
  end

  def self.down
   remove_column :messages, :html_text
  end
end

