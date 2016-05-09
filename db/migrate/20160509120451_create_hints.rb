class CreateHints < ActiveRecord::Migration
  def change
    create_table :hints do |t|
      t.string :cate
      t.string :hint
      t.timestamps
    end
  end
end
