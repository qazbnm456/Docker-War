class AddOpenAndOutlineToAllChallengeTables < ActiveRecord::Migration
  def change
    add_column :basics, :open, :boolean, :default => false
    add_column :reverses, :open, :boolean, :default => false
    add_column :cryptos, :open, :boolean, :default => false
    add_column :webs, :open, :boolean, :default => false
    add_column :pwns, :open, :boolean, :default => false

    add_column :basics, :outline, :string, :default => 'Not yet ready.'
    add_column :reverses, :outline, :string, :default => 'Not yet ready.'
    add_column :cryptos, :outline, :string, :default => 'Not yet ready.'
    add_column :webs, :outline, :string, :default => 'Not yet ready.'
    add_column :pwns, :outline, :string, :default => 'Not yet ready.'
  end
end
