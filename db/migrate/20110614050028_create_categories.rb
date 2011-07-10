class CreateCategories < ActiveRecord::Migration
  def self.up
    create_table :categories do |t|
      t.string :name
      t.integer :person_id

      t.timestamps
    end
    add_index :categories, :person_id
  end

  def self.down
    drop_table :categories
  end
end
