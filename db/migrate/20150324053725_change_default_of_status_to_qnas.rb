class ChangeDefaultOfStatusToQnas < ActiveRecord::Migration
  def change
    change_column(:qnas, :status, :integer, :default => 0)
  end
end
