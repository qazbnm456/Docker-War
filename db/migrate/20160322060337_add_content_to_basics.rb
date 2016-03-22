class AddContentToBasics < ActiveRecord::Migration
  def change
    add_column :basics, :content, :text, :limit => 5, :null => true
  end
end
