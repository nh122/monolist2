class RenameCodeColumnToOwnerships < ActiveRecord::Migration
  def change
    rename_column :ownerships, :item_code, :code
  end
end
