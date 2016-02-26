class AddRecordIdToUsers < ActiveRecord::Migration
  def change
    add_column :users, :record_id, :integer
  end
end
