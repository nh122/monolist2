class RenameColumnItemcode < ActiveRecord::Migration
  def change
    rename_column :items, :code, :item_code
  end
end
