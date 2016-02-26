class CreateRecords < ActiveRecord::Migration
  def change
    create_table :records do |t|
      t.string :cate
      t.boolean :solved, :default => false
    end
  end
end
