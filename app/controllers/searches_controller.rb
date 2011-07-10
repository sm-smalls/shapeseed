class SearchesController < ApplicationController

  def create  
    @search = Search.new(params[:search])
	if @search.save
	  if params[:search][:query].blank?
	    flash[:notice] = "Please provide a query"
	    render 'index'
	  else
	    #*******
	    #This is for sunspot ... right now using acts_as_indexed to start
#         @results = Work.search do 
#           keywords params[:search][:query]
#           paginate(:page => params[:page], :per_page => 10)
#         end.results
	    #*******
	
	    #acts_as_indexed
	    @results = Work.find_with_index(params[:search][:query])
	  end
	  @search.set_ages
	  @results = @results.partition{|work| (work.age <= @search.max_age && 
	  										work.age >= @search.min_age)}[0]
	  @people_results = @results.map{|work| Person.find(work.person_id)}
	  @search.save_results(@results.map(&:id).join(" "))
      render 'search'
    else
      render 'index'
    end
  end
  
  def index
    @search = Search.new
    render 'index'
  end
  
end





#      @sunspot_search = Sunspot.search User, Tag, Work do |query| 
 #       query.keywords @search.query
  #      query.with(:age).greater_than @lower
   #     query.with(:age).less_than @upper
    #    query.paginate(:page => params[:page], :per_page => 10)
     # end