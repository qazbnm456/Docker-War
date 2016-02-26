class CreateCryptos < ActiveRecord::Migration
  def change
    create_table :cryptos do |t|
      t.string  :title
      t.string  :url
      t.string  :flag
      t.timestamps
    end
  end
end
