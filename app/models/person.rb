class Person < ActiveRecord::Base

  #before_validation :parse_name

  has_many :works, :dependent => :destroy
  has_many :tags, :through => :works, :uniq => true, :dependent => :destroy
  has_many :categories, :uniq => true, :dependent => :destroy
  
  attr_accessible :first, :last, :description, :title, :name
  
  #The person's followers
  has_many :reverse_mentorships,   :foreign_key => "mentor_id",
  								   :class_name => "Mentorship",
  								   :dependent => :destroy
  has_many :mentees,   :through => :reverse_mentorships, :source => :mentee
  
  #The person's contributors
  has_many :reverse_contributions, 	  :foreign_key => "contributed_id",
								   	  :class_name => "Contribution",
								      :dependent => :destroy
  has_many :contributors, :through => :reverse_contributions, :source => :contributor
  
  validates :last,  		:presence => true,
  						 	:length => { :maximum => 25 }
  validates :first, 		:presence => true,
  				   		 	:length   => { :maximum => 25 }
  validates :description,	:presence => true,
  						 	:length => { :within => 6..350 }
  validates :title, 	 	:presence => true,
  					     	:length => { :within => 3..150 }
  
 # after_save :create_contribution
  #after_save :create_mentorship
  
  def get_works
    Work.where("person_id = ?", id)
  end
  
  def get_categories(person)
    person.categories
  end
  
  def get_unique_tags(person)
    person.tags.index_by{|elem| elem[:name]}.values
  end 
  
  def name
    "#{@first} #{@last}"
  end
  
  def parse_name
    parsed = name.split(" ")
    self.first = parsed[0]
    self.last = parsed[parsed.length - 1]
  end
end

