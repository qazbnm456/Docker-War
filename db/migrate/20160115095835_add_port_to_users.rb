class AddPortToUsers < ActiveRecord::Migration
  def change
    add_column :users, :port, :integer, :limit => 2, :null => true, :unsigned => true
  end
end
