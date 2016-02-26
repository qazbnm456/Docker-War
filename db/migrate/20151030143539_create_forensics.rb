class CreateForensics < ActiveRecord::Migration
  def change
    create_table :forensics do |t|
      t.string  :title
      t.string  :url
      t.string  :flag
      t.timestamps
    end
  end
end
