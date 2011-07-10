require 'spec_helper'

describe User do
  
  before(:each) do 
    @attr = { :name => "Example User", 
    		  :age => "04/11/1983",
    		  :email => "user@example.com",
    		  :password => "foobar",
    		  :password_confirmation => "foobar"
    		}
  end
  
  it "should create a new instance given valid attributes" do
    User.create!(@attr)
  end
  
  it "should require a name" do
    no_name_user = User.new(@attr.merge(:name => ""))
    no_name_user.should_not be_valid
  end
  
  it "should require an email address" do
    no_email_user = User.new(@attr.merge(:email => ""))
    no_email_user.should_not be_valid
  end
  
  it "should reject names that are too long" do
    long_name = "a" * 51
    long_name_user = User.new(@attr.merge(:name => long_name))
    long_name_user.should_not be_valid
  end
  
  it "should accept valid email addresses" do
    addresses = %w[foo@bar.com THE_FOO@bar.baz.org first.last@foo.ly]
    addresses.each do |address|
      valid_email_user = User.new(@attr.merge(:email => address))
      valid_email_user.should be_valid
    end
  end
  
  it "should reject invalid email addresses" do
    addresses = %w[foo@bar,com the_foo_at_bar.org first.last@foo.]
    addresses.each do |address|
      invalid_email_user = User.new(@attr.merge(:email => address))
      invalid_email_user.should_not be_valid
    end
  end
  
  it "should reject duplicate email addresses" do
    upcased_email = @attr[:email].upcase
    User.create!(@attr.merge(:email => upcased_email))
    user_with_duplicate_email = User.new(@attr)
    user_with_duplicate_email.should_not be_valid
  end
  
  describe "password validations" do
    it "should require a password" do
      hash = @attr.merge(:password => "", :password_confirmation => "")
      User.new(hash).should_not be_valid
    end
    
    it "should reject short passwords" do
      short = "a" * 5
      hash = @attr.merge(:password => short, :password_confirmation => short)
      User.new(hash).should_not be_valid
    end
    
    it "should require a matching password confirmation" do
      hash = @attr.merge(:password_confirmation => "invalid")
      User.new(hash).should_not be_valid
    end
    
    it "should reject long passwords" do
      long = "a" * 41
      hash = @attr.merge(:password => long, :password_confirmation => long)
      User.new(hash).should_not be_valid
    end
  end
  
  describe "password encryption" do
    before(:each) do
      @user = User.create!(@attr)
    end
    
    it "should have an encrypted password attribute" do
      @user.should respond_to(:encrypted_password)
    end
    
    it "should set the encrypted password" do
      @user.encrypted_password.should_not be_blank
    end
    
    describe "has_password? method" do
      it "should be true if the passwords match" do
        @user.has_password?(@attr[:password]).should be_true
      end
      
      it "should be false if the passwords dont match" do
        @user.has_password?("invalid").should be_false
      end
    end
    
    describe "authenticate method" do
      it "should return nil on e/p mismatch" do
        wrong_password_user = User.authenticate(@attr[:email], "wrongpass")
        wrong_password_user.should be_nil
      end
      
      it "should return nil for email with no user" do
        nonexistent_user = User.authenticate("b@f.com", @attr[:password])
        nonexistent_user.should be_nil
      end
      
      it "should return the user on e/p match" do
        matching_user = User.authenticate(@attr[:email], @attr[:password])
        matching_user.should == @user
      end
    end
  end
  
  describe "admin attribute" do
    before(:each) do
      @user = User.create!(@attr)
    end

    it "should respond to admin" do
      @user.should respond_to(:admin)
    end

    it "should not be an admin by default" do
      @user.should_not be_admin
    end

    it "should be convertible to an admin" do
      @user.toggle!(:admin)
      @user.should be_admin
    end
  end
  
  describe "work associations" do
    before(:each) do
      @user = User.create(@attr)
      @work1 = Factory(:work, :user => @user, :age => 10, :name => "aops")
      @work2 = Factory(:work, :user => @user, :age => 5, :name => "lecture3")
      @work3 = Factory(:work, :user => @user, :age => 7, :name => "sciam")
    end
    
    it "should have a works attribute" do
      @user.should respond_to(:works)
    end
    
    it "should have the right works in the right order" do
      #Should be ordered by age
      @user.works.should == [@work2, @work3, @work1]
    end
    
    it "should destroy associated works" do
      @user.destroy
      [@work1, @work2, @work3].each do |work|
        Work.find_by_id(work.id).should be_nil
      end
    end
    
    describe "timeline" do
      it "should have a timeline" do
        @user.should respond_to(:timeline)
      end
      
      it "should include the user's works" do
        @user.timeline.include?(@work1).should be_true
        @user.timeline.include?(@work3).should be_true
        @user.timeline.include?(@work2).should be_true
      end
      
      it "should not include a different user's works" do
        work4 = Factory(:work, :user => Factory(:user, :email => Factory.next(:email), :age => "04/11/1983"),
        					   :age => 15)
        @user.timeline.include?(work4).should be_false
      end
    end
  end
  
  describe "relationships" do
    before(:each) do
      @user = User.create!(@attr)
      @followed = Factory(:user)
    end
    
    it "should have a relationships method" do
      @user.should respond_to(:relationships)
    end
    
    it "should have a following method" do
      @user.should respond_to(:following)
    end
    
    it "should have a following? method" do
      @user.should respond_to(:following?) 
    end
    
    it "should have a follow! method" do
      @user.should respond_to(:follow!) 
    end
    
    it "should follow another user" do
      @user.follow!(@followed)
      @user.should be_following(@followed)
    end
    
    it "should include the followed user in the following array" do
      @user.follow!(@followed)
      @user.following.should include(@followed)
    end
    
    it "should have an unfollow! method" do
      @followed.should respond_to(:unfollow!)
    end
    
    it "should unfollow a user" do
      @user.follow!(@followed)
      @user.unfollow!(@followed)
      @user.should_not be_following(@followed)
    end
    
    it "should have a reverse_relationships method" do
      @user.should respond_to(:reverse_relationships)
    end
    
    it "should have a followers method" do
      @user.should respond_to(:followers)
    end
    
    it "should include the follower in the followers array" do
      @user.follow!(@followed)
      @followed.followers.should include(@user)
    end
  end
end
