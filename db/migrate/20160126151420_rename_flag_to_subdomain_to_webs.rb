class RenameFlagToSubdomainToWebs < ActiveRecord::Migration
  def change
    rename_column :webs, :flag, :subdomain
  end
end
