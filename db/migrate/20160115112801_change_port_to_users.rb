class ChangePortToUsers < ActiveRecord::Migration
  def change
    change_column :users, :port, :integer, :limit => 5, :null => true, :unsigned => true
  end
end
