# == Schema Information
# Schema version: 20110403181559
#
# Table name: users
#
#  id         :integer         not null, primary key
#  first_name :string(255)
#  last_name  :string(255)
#  email      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

require 'digest'

class User < ActiveRecord::Base

  #for authlogic
  acts_as_authentic
  
  attr_accessible :first, :last, :email, :password, :password_confirmation 
    
  #Normal Relationships among users ... follow, be followed
  has_many :relationships, :foreign_key => "follower_id", :dependent => :destroy
  has_many :following, :through => :relationships, :source => :followed
  has_many :reverse_relationships, :foreign_key => "followed_id",
  								   :class_name => "Relationship",
  								   :dependent => :destroy
  has_many :followers, :through => :reverse_relationships, :source => :follower
  
  #Relationships with mentors. Follow a mentor. A mentor is followed
  has_many :mentorships, :foreign_key => "mentee_id", :dependent => :destroy
  has_many :mentors, :through => :mentorships, :source => :mentor
  
  #Contributions to mentors. You are again only following
  has_many :contributions, :foreign_key => "contributor_id", :dependent => :destroy
  has_many :contributeds, :through => :contributions, :source => :contributed
  
  email_regex = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  
  validates :last,  	 :presence => true,
  						 :length => { :maximum => 25 }
  validates :first, 	 :presence => true,
  				   		 :length   => { :maximum => 25 }
  validates :email, 	 :presence => true,
  						 :uniqueness => { :case_sensitive => false }
  						 #:format   => { :with => email_regex },
  						 #:length => { :within => 6..100 }
  validates :password, 	 :presence => true,
  					     :confirmation => true
  					     #:length => { :within => 6..40 }
  
  #Relationship functions
  def following?(followed)
    relationships.find_by_followed_id(followed)
  end
  
  def follow!(followed)
    relationships.create!(:followed_id => followed.id)
  end
  
  def unfollow!(followed)
    relationships.find_by_followed_id(followed).destroy
  end
  #End
  
  #Contribution Functions
  def contribute!(contributed, work)
    contributions.create!(:contributed_id => contributed.id, :work_id => work.id)
  end
  
  def contribute?(contributed)
    contributions.find_by_contributed_id(contributed)
  end
  #End
  
  #Mentorship functions
  def mentee!(mentor)
    mentorships.create!(:mentor_id => mentor.id)
  end
  
  def unmentee!(mentor)
    mentorships.find_by_mentor_id(mentor).destroy
  end
  
  def mentoree?(mentor)
    mentorships.find_by_mentor_id(mentor)
  end 
  #End
  
  def name
    "#{@first_name} #{@last_name}"
  end
  
end

