class TagsController < ApplicationController
  before_filter :require_user
  
  def create
    @work = Work.find(params[:id])
	@tag = @work.tags.build(params[:tag])
	if @tag.save
	  flash[:success] = "Tagged!"
	  redirect_back_or root_path
	else
	  render 'pages/home'
	end
  end
  
  def destroy
    @tag.destroy
    redirect_back_or root_path
  end
end