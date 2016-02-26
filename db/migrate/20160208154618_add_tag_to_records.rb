class AddTagToRecords < ActiveRecord::Migration
  def change
    add_column :records, :tag, :string
    change_column :records, :tag, :string, :null => false
  end
end
