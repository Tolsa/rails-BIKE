class AddTitleToEntries < ActiveRecord::Migration[5.1]
  def change
    add_column :entries, :title, :string
    add_column :entries, :link, :string
  end
end
