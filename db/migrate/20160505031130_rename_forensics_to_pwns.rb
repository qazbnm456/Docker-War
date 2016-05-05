class RenameForensicsToPwns < ActiveRecord::Migration
  def change
    rename_table :forensics, :pwns
  end
end
