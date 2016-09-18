class AddItemCodeToOwnerships < ActiveRecord::Migration
  def change
    add_column :ownerships, :age, :string
  end
end
