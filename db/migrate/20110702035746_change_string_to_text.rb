class ChangeStringToText < ActiveRecord::Migration
  def self.up
    change_column :works, :content, :text
    change_column :people, :title, :text
    change_column :people, :description, :text
  end

  def self.down
  end
end
