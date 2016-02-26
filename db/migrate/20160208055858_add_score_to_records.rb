class AddScoreToRecords < ActiveRecord::Migration
  def change
    add_column :records, :score, :integer, :limit => 5, :default => 0, :null => true, :unsigned => true
  end
end
