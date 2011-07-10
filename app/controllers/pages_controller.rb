class PagesController < ApplicationController
  before_filter :set_user
  
  def home
    @title = "Home"
    @search = Search.new
    @work_results = Person.all.shuffle.
    						   map{|person| person.works[rand(person.works.length)]}.
    						   reject{|item| item.nil?}
    @people_results = @work_results.map{|work| Person.find(work.person_id)}
  end
  
  def about
    @search = Search.new
    @title = "About"
  end
  
  def contact
    @search = Search.new
    @title = "Contact"
  end

end
