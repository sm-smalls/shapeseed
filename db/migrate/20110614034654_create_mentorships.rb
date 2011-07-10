class CreateMentorships < ActiveRecord::Migration
  def self.up
    create_table :mentorships do |t|
      t.integer :mentor_id
      t.integer :mentee_id

      t.timestamps
    end
    add_index :mentorships, :mentor_id
    add_index :mentorships, :mentee_id
    add_index :mentorships, [:mentor_id, :mentee_id], :unique => true
  end

  def self.down
    drop_table :mentorships
  end
end

