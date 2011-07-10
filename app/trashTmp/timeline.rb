class Timeline < ActiveRecord::Base
  attr_accessible :age
  
  belongs_to :user
  
  validates :age, :presence => true, :numericality => { :greater_than => 0 }
  validates :user_id, :presence => true
end

