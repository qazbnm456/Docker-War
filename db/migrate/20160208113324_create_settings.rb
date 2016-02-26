class CreateSettings < ActiveRecord::Migration
  def change
    create_table :settings do |t|
      t.string :tag, :null => false
    end
  end
end
