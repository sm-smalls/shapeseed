class AddNameToPeople < ActiveRecord::Migration
  def self.up
    add_column :people, :name, :string
  end

  def self.down
    remove_column :people, :name
  end
end
