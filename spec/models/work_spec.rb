require 'spec_helper'

describe Work do
  before(:each) do
    @user = Factory(:user)
    @attr = { :content => "value for content", :age => 15, 
    		  :where => "location", :name => "title", :category => "category"}
  end
  
  it "should create a new instance given valid attributes" do
    @user.works.create!(@attr)
  end
  
  describe "user associations" do
    before(:each) do
      @work = @user.works.create(@attr)
    end
    
    it "should have a user attribute" do
      @work.should respond_to(:user)
    end
    
    it "should have the right associated user" do
      @work.user_id.should == @user.id
      @work.user.should == @user
    end
  end
  
  describe "validations" do
    it "should require a user id" do
      Work.new(@attr).should_not be_valid
    end
    
    it "should require nonblank content" do
      @user.works.build(:content => " ", :age => 15).should_not be_valid
    end
    
    it "should require nonblank age" do
      @user.works.build(:content => "valid", :age => " ").should_not be_valid
    end
    
    it "should require nonnegative age" do
      @user.works.build(:content => "valid", :age => 0).should_not be_valid
    end
  end
end

