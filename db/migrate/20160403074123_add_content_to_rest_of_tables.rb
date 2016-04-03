class AddContentToRestOfTables < ActiveRecord::Migration
  def change
    add_column :cryptos, :content, :text, :limit => 65535, :null => true
    add_column :forensics, :content, :text, :limit => 65535, :null => true
    add_column :reverses, :content, :text, :limit => 65535, :null => true
    add_column :webs, :content, :text, :limit => 65535, :null => true
  end
end
