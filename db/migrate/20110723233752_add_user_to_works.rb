class AddUserToWorks < ActiveRecord::Migration
  def self.up
    add_column :works, :contributor_id, :integer
  end

  def self.down
    remove_column :works, :contributor_id
  end
end
