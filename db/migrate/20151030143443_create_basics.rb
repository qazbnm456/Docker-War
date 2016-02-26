class CreateBasics < ActiveRecord::Migration
  def change
    create_table :basics do |t|
      t.string  :title
      t.string  :url
      t.string  :flag
      t.timestamps
    end
  end
end
