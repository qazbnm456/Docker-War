class AddMissingIndexes < ActiveRecord::Migration
  def change
    add_index :merit_scores, :sash_id
    add_index :merit_score_points, :score_id
    add_index :users, :sash_id
    add_index :users, :major_id
    add_index :users, :sex_id
    add_index :merit_activity_logs, :action_id
    add_index :merit_activity_logs, [:related_change_id, :related_change_type], :name => 'index_merit_activity_logs_on_rcid_and_rctype'
    add_index :records, :user_id
  end
end
