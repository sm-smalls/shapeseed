class AddAttrToWorks < ActiveRecord::Migration
  def self.up
    add_column :works, :name, :string
  end

  def self.down
    remove_column :works, :name
  end
end
