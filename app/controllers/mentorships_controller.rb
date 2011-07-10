class MentorshipsController < ApplicationController
  before_filter :require_user
  
  def create
    @person = Person.find(params[:mentorship][:mentor_id])
    current_user.mentee!(@person)
    respond_to do |format|
      format.html { redirect_to root }
      format.js
    end
  end
  
  def destroy
    @person = Mentorship.find(params[:id]).mentor
    current_user.unmentee!(@person)
    respond_to do |format|
      format.html { redirect_to root }
      format.js
    end
  end
end