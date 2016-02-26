class AddFinishTimeToRecords < ActiveRecord::Migration
  def change
    add_column :records, :finish_time, :datetime
  end
end
