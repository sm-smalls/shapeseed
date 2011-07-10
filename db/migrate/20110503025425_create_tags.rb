class CreateTags < ActiveRecord::Migration
  def self.up
    create_table :tags do |t|
      t.string  :name
      t.integer :work_id

      t.timestamps
    end
    add_index :tags, :work_id
  end

  def self.down
    drop_table :tags
  end
end
