class CreateContributions < ActiveRecord::Migration
  def self.up
    create_table :contributions do |t|
      t.integer :contributed_id
      t.integer :contributor_id
      t.integer :work_id

      t.timestamps
    end
    add_index :contributions, :contributed_id
    add_index :contributions, :contributor_id
    add_index :contributions, :work_id
  end

  def self.down
    drop_table :contributions
  end
end
