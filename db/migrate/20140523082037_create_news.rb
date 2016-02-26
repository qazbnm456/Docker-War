class CreateNews < ActiveRecord::Migration
  def change
    create_table :news do |t|
      t.string :messages
      t.datetime :date
    end
  end
end