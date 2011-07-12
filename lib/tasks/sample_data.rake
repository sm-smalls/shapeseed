
namespace :db do
  desc "Put in Admin"
  task :populate => :environment do
    Rake::Task['db:reset'].invoke
    make_users
  end
end

def make_users
  admin = User.create!(:first => "Cinjon",
  					   :last  => "Resnick",
  			 		   :email => "cinjon.resnick@gmail.com",
			 		   :password => "966S41nt",
			 		   :password_confirmation => "966S41nt")
  admin.toggle!(:admin) #makes admin into an ... admin
end
