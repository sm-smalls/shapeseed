class ContributionController < ApplicationController
  before_filter :require_user
    
  def create
    @person = Person.find(params[:contribution][:contributed_id])
    current_user.contribute!(@user)
  end

  def destroy
    @user = Relationship.find(params[:id]).followed
    current_user.unfollow!(@user)
  end

end
