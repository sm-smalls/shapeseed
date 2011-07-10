class AddAgeToWorks < ActiveRecord::Migration
  def self.up
    add_column :works, :age, :integer
  end

  def self.down
    remove_column :works, :age
  end
end
