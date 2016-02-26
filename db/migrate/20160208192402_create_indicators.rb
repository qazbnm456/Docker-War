class CreateIndicators < ActiveRecord::Migration
  def change
    create_table :indicators do |t|
      t.boolean :value, :default => false
    end
  end
end
