class PeopleController < ApplicationController
  before_filter :require_user, :only => [:create, :update, :destroy]

  def show
    @person = Person.find(params[:id])
    @timeline_works_js = @person.works.reject{|work| work.blank?}
    @user = current_user
    @search = Search.new
    #@works = @person.works.paginate(:page => params[:page])
    @signed_bool = true unless !@user
    @timeline_tags_js = @person.works.collect{|work| work.tags.map(&:name).join(" ")}
    @tl_length = @timeline_works_js.length
    @tags = @person.get_unique_tags(@person)
    @work = Work.new
    @title = "#{@person.first} #{@person.last}" 
  end
  
  def create
    parsed = params[:person][:name].split(" ")
    first = parsed[0]
    last = parsed[parsed.length - 1]
	@person = Person.new(:title => params[:person][:title], :description => params[:person][:description],
						 :first => first, :last => last)
	if @person.save
	  current_user.contribute!(@person)
	  if !current_user.mentoree?(@person)
		current_user.mentee!(@person)
	  end
	  redirect_to @person
	else
	  redirect_to suggest_path
    end
  end
  
  def contribute
    @search = Search.new
    @person = Person.find(params[:id])
    @title = "#{@person.first} #{@person.last}"
  end

  def update
  end

  def destroy
  end

end
