class CreateWorks < ActiveRecord::Migration
  def self.up
    create_table :works do |t|
      t.string :content
      t.integer :person_id

      t.timestamps
    end
    add_index :works, :person_id
  end

  def self.down
    drop_table :works
  end
end
