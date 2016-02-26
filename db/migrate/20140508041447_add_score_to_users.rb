class AddScoreToUsers < ActiveRecord::Migration
  def change
    add_column :users, :score, :integer
    add_index :users, :score
  end
end
