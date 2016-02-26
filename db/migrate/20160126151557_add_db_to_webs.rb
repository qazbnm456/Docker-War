class AddDbToWebs < ActiveRecord::Migration
  def change
    add_column :webs, :db, :string
  end
end
