class CreateMajors < ActiveRecord::Migration
  def change
    create_table :majors do |t|
        t.string :name
    end
  end
end
