class AddPriceToEntries < ActiveRecord::Migration[5.1]
  def change
    add_column :entries, :description, :string
    add_column :entries, :price, :integer
  end
end
