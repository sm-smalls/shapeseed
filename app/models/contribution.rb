class Contribution < ActiveRecord::Base
  attr_accessible :contributed_id
  
  belongs_to :contributed, :class_name => "Person"
  belongs_to :contributor, :class_name => "User"
  belongs_to :work,        :class_name => "Work"
  
  validates :contributed_id, :presence => true
  validates :contributor_id, :presence => true
  validates :work_id,        :presence => true
    
end
