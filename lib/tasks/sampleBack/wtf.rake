require 'faker'

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_admin
    #make_users
    #make_people
    #make_works
    #make_relationships
    #make_contributions
    #make_mentorships
    #make_tags
    #make_categories
  end
end

def make_admin
  admin = User.create!(:first => "Cinjon",
  					   :last  => "Resnick",
  			 		   :email => "cinjon@resnick.com",
			 		   :password => "P4ssw0rd",
			 		   :password_confirmation => "P4ssw0rd")
  admin.toggle!(:admin) #makes admin into an ... admin
end

def make_users
  100.times do |n|
    first_name  = Faker::Name.first_name
    last_name   = Faker::Name.last_name
    email = "user-#{n+1}@example.org"
    password  = "P4ssw0rd"
    user = User.create!(:first => first_name,
    			 		:last => last_name,
			     		:email => email,
			     		:password => password,
			     		:password_confirmation => password)
  end
end

def make_people
  users = User.all
  15.times do |n|
    first 		= Faker::Name.first_name
    last  		= Faker::Name.last_name
    description = Faker::Lorem.sentence(2)
    title 		= Faker::Lorem.sentence(2)
    user 		= users[rand(users.length)]
    person 		= Person.create!(:first => first,
    			   				 :last  => last,
    			   				 :description => description,
    			  				 :title => title)
    user.contribute!(person)
  end    
end

def make_works
  Person.all(:limit => 15).each do |person|
    7.times do |a|
      maxAge = 45
      age = 5 + rand(maxAge - 5)
      person.works.create!(:content => Faker::Lorem.sentence(3), 
        				   :age => age,
        				   :name => Faker::Lorem.sentence(1))
    end
  end
end

def make_tags
  Person.all(:limit => 15).each do |person|
    person.works.each do |work|
      (rand (3)).times do |a|
        work.tags.create!(:name => "#{work.id}tag")
      end
    end
  end
end

def make_categories
  Person.all(:limit => 15).each do |person|
    (rand (3)).times do |a|
      person.categories.create!(:name => "#{person.id}category")
    end
  end
end

def make_relationships 
  users = User.all
  user = users.first
  following = users[1..30]
  followers = users[3..20]
  following.each { |followed| user.follow!(followed) }
  followers.each { |follower| follower.follow!(user) }
end

def make_contributions
  users = User.all
  Person.all.each do |mentor|
    (rand(7)).times do |a|
      index = rand(users.length)
      users[index].contribute!(mentor)
    end
  end
end

def make_mentorships
  users = User.all
  Person.all(:limit => 25).each do |person|
    (rand(3) + 1).times do |a|
      user = users[rand(users.length)]
      if !user.mentoree?(person)
        user.mentee!(person)
      end
    end
  end
end
      

    