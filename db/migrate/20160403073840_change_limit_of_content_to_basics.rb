class ChangeLimitOfContentToBasics < ActiveRecord::Migration
  def change
    change_column :basics, :content, :text, :limit => 65535, :null => true
  end
end
