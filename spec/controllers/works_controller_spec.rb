require 'spec_helper'

describe WorksController do
  render_views

  describe "access control" do
    it "should deny access to 'create'" do
      post :create
      response.should redirect_to(signin_path)
    end

    it "should deny access to 'destroy'" do
      delete :destroy, :id => 1
      response.should redirect_to(signin_path)
    end
  end
  
  describe "POST 'create'" do
    before(:each) do
      @user = test_sign_in(Factory(:user))
    end

    describe "failure" do
      before(:each) do
        @attr = { :content => "", :age => 0 }
      end

      it "should not create a work" do
        lambda do
          post :create, :work => @attr
        end.should_not change(Work, :count)
      end

      it "should render the home page" do
        post :create, :work => @attr
        response.should render_template('pages/home')
      end
    end

    describe "success" do
      before(:each) do
        @attr = { :content => "Book x", :age => 10, :where => "location",
        		  :category => "category", :name => "title" }
      end

      it "should create a work" do
        lambda do
          post :create, :work => @attr
        end.should change(Work, :count).by(1)
      end

      it "should redirect to the home page" do
        post :create, :work => @attr
        response.should redirect_to(root_path)
      end

      it "should have a flash message" do
        post :create, :work => @attr
        flash[:success].should =~ /work added/i
      end
    end
  end
  
  describe "DELETE 'destroy'" do
    describe "for an unauthorized user" do
      before(:each) do
        @user = Factory(:user)
        wrong_user = Factory(:user, :email => Factory.next(:email))
        test_sign_in(wrong_user)
        @work = Factory(:work, :user => @user)
      end

      it "should deny access" do
        delete :destroy, :id => @work
        response.should redirect_to(root_path)
      end
    end

    describe "for an authorized user" do
      before(:each) do
        @user = test_sign_in(Factory(:user))
        @work = Factory(:work, :user => @user)
      end

      it "should destroy the work" do
        lambda do 
          delete :destroy, :id => @work
#           flash[:success].should =~ /deleted/i
#           response.should redirect_to(root_path)
        end.should change(Work, :count).by(-1)
      end
    end
  end
end
