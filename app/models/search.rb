class Search < ActiveRecord::Base
  attr_accessible :query, :min_age, :max_age, :work_results
  
  validates_numericality_of :min_age, :allow_nil => true, :greater_than_or_equal_to => 0, 
  									  :less_than_or_equal_to => 100, :only_integer => true,
  									  :message => "should be blank or an integer between 0 and 100"
  validates_numericality_of :max_age, :allow_nil => true, :greater_than_or_equal_to => 0, 
  									  :less_than_or_equal_to => 100, :only_integer => true,
  									  :message => "should be blank or an integer between 0 and 100"
  validates 				:query,   :presence => true
  
  def set_ages
	check_min
	check_max
	check_switch
    self.update_attributes(:min_age => @min_age, :max_age => @max_age)
  end
  
  def has_min_age?
    min_age.present?
  end
  
  def has_max_age?
    max_age.present?
  end
  
  def has_query?
    query.present?
  end
  
  def switch_ages?
    @max_age < @min_age
  end
  
  def save_results(results) 
    #save results here 
    self.update_attributes(:work_results => results)
  end
  
  private 
    def check_max
      if has_max_age?
        @max_age = max_age
      else
        @max_age = 100
      end
    end
    
    def check_min
      if has_min_age?
        @min_age = min_age
      else
        @min_age = 0
      end
    end
    
    def check_switch
      if switch_ages?
        @tmp = min_age
        @min_age = @max_age
        @max_age = @tmp
      end
    end
end


