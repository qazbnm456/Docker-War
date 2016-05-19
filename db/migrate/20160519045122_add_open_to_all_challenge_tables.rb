class AddOpenToAllChallengeTables < ActiveRecord::Migration
  def change
    add_column :basics, :open, :boolean, :default => false
    add_column :reverses, :open, :boolean, :default => false
    add_column :cryptos, :open, :boolean, :default => false
    add_column :webs, :open, :boolean, :default => false
    add_column :pwns, :open, :boolean, :default => false
  end
end
