class TimelinesController < ApplicationController
  before_filter :authorized_user, :only => :destroy
  before_filter :authenticate, :only => [:create, :destroy]
  
  def create
    @timeline = current_user.timeline.build(params[:timeline])
    if @timeline.save
      flash[:success] = "Timeline Created!"
      redirect_to root_path
    else
      @timeline_items = []
      render 'pages/home'
    end
  end
  
  def destroy
    @timeline.destroy
    redirect_back_or root_path
  end
  
  
  private
    def authorized_user
      @timeline = Timeline.find(params[:id])
      redirect_to root_path unless current_user?(@timeline.user)
    end
end