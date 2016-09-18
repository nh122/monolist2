class RenameAgeColumnToOwnerships < ActiveRecord::Migration
  def change
    rename_column :ownerships, :age, :item_code
  end
end
