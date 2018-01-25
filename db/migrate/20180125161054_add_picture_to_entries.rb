class AddPictureToEntries < ActiveRecord::Migration[5.1]
  def change
    add_column :entries, :picture, :string
  end
end
