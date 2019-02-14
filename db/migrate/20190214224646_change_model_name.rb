class ChangeModelName < ActiveRecord::Migration[5.2]
  def change
    rename_table :images, :image
  end
end
