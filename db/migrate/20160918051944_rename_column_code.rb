class RenameColumnCode < ActiveRecord::Migration
  def change
    rename_column :ownerships, :code, :item_code
    rename_column :items, :item_code, :code
  end
end
