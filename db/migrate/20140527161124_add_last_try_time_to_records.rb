class AddLastTryTimeToRecords < ActiveRecord::Migration
  def change
    add_column :records, :last_try_time, :datetime
  end
end
