class Category < ActiveRecord::Base
  attr_accessible :name
  
  belongs_to :person

  validates :name,     	 :presence => true
  validates :person_id,  :presence => true
  
  #Orders by name in ascending order
  default_scope :order => 'categories.name ASC'
  
  def self.get_person_categories(person)
    where("person_id = ?", person)
  end
  
  searchable :auto_index => true, :auto_remove => true do
    text :name
  end
end
