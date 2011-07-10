class Work < ActiveRecord::Base
  attr_accessible :content, :age, :name
  
  belongs_to :person
  has_many :tags
  
  validates 				:name,       :presence => true
  validates					:content,	 :presence => true
  validates_numericality_of :age, 	     :greater_than => 0, :less_than => 100,
  					   			  		 :message => "should be an integer between 0 and 100"
  validates 				:person_id,  :presence => true
  
  #for acts_as_indexed
  acts_as_indexed :fields => [:person_name, :tag_names, :person_categories, :content, :name]
  
  #Orders by age in ascending order
  default_scope :order => 'works.age ASC'
  
  def self.get_person_works(person)
    where("person_id = ?", person)
  end
  
  #For use with sunspot
#   searchable :auto_index => true, :auto_remove => true do
#     text :user_name, :default_boost => 3.0
#     text :tag_names, :default_boost => 4.0
#     text :content,   :default_boost => 2.0
#     text :name, :default_boost => 2.0
#   end
  
  def person_name 
    "#{person.first} #{person.last}"
  end

  def tag_names
   	person.tags.map(&:name).join(" ")
  end
  
  def person_categories
    person.categories.map(&:name).join(" ")
  end
  
end


