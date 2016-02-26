class RemoveRecordIdToUsers < ActiveRecord::Migration
  def change
    remove_column(:users, :record_id)
  end
end
