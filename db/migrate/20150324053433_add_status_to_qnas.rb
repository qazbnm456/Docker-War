class AddStatusToQnas < ActiveRecord::Migration
  def change
    add_column :qnas, :status, :integer
  end
end
