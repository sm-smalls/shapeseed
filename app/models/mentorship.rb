class Mentorship < ActiveRecord::Base
  attr_accessible :mentor_id
  
  belongs_to :mentee, :class_name => "User"
  belongs_to :mentor, :class_name => "Person"
  
  validates :mentee_id, :presence => true
  validates :mentor_id, :presence => true
end
