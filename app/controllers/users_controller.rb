class UsersController < ApplicationController
  before_filter :require_user, :except => [:new, :create, :relations]
  before_filter :correct_user, :only => [:edit, :update]
  before_filter :admin_user,   :only => [:edit, :update, :destroy]
  before_filter :require_no_user, :only => [:create, :new]
  
  def new
    @user = User.new
    @title = "Sign Up"
    @user_session = UserSession.new
    @search = Search.new
  end
  
  def show
    redirect_to(root_path) #in here right now because i dont want to make this part yet
    @user = User.find(params[:id])
    @title = "#{@user.first_name} #{@user.last_name}" 
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
	  #sign_in @user
	  #flash[:success] = "Welcome to ShapeSeed"
	  redirect_to root_path
    else
	  @title = "Sign Up"
	  @user.password = User.new.password
	  @user.password_confirmation = User.new.password_confirmation
	  redirect_to signup_path
    end
  end
  
  def update
    if @user.update_attributes(params[:user])
      #flash[:success] = "Profile updated"
      redirect_to @user
    else
      @title = "Edit User"
      render 'edit'
    end
  end
  
  def destroy 
    @user = User.find(params[:id])
    if !@user.admin?
      @user.destroy
      #flash[:success] = "User Removed."
    end
    redirect_to users_path
  end
  
  def relations
    @search = Search.new
    @user = current_user
    @title = "#{@user.first}"
    @mentors = @user.mentors
    @contributeds = @user.contributeds.index_by{|person| person[:id]}.values
    render 'show_relations'
  end
  
  def suggest
    @search = Search.new
    @title = "Suggest"
    @person = Person.new
    @user = current_user
    render 'suggest'
  end
  
  private
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end
    
    def admin_user
      @user = User.find(params[:id])
      redirect_to(root_path) if !current_user.admin? || current_user?(@user)
    end
end
