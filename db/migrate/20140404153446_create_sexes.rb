class CreateSexes < ActiveRecord::Migration
  def change
    create_table :sexes do |t|
        t.string :name
    end
  end
end
