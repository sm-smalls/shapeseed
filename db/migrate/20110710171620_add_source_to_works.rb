class AddSourceToWorks < ActiveRecord::Migration
  def self.up
    add_column :works, :source, :text
  end

  def self.down
    remove_column :works, :source
  end
end
