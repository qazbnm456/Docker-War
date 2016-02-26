class ChangeDefalutOfScoreToUsers < ActiveRecord::Migration
  def change
    change_column(:users, :score, :integer, :default => 0)
  end
end
