class AddActiveToSettings < ActiveRecord::Migration
  def change
    add_column :settings, :active, :boolean, :default => false
  end
end
