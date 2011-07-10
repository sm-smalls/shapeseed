module ApplicationHelper
  
  def logo
    image_tag("logo.png", :alt => "Transform", :class => "round")
  end
  
  def title
    base_title = "ShapeSeed"
    if @title.nil?
      base_title
    else
      "#{@title}"
    end
  end
  
  def gravatar_url_for(email, options = {})      
    url_for({:gravatar_id => Digest::MD5.hexdigest(email), 
     		 :host => 'www.gravatar.com',                     
     		 :protocol => 'http://', 
     		 :only_path => false,
     		 :rating => 'G',
     		 :controller => 'avatar.php'}.merge(options))  
  end

  
  # plain old gravatar url  <%= gravatar_url_for 'greenisus@gmail.com' %>    
  # gravatar url with a rating threshold   <%= gravatar_url_for 'greenisus@gmail.com', { :rating => 'R' } %>    
  # show the avatar   <%= image_tag(gravatar_url_for 'greenisus@gmail.com')%>   
  # show the avatar with size specified, in case it's served slowly  
    #<%= image_tag(gravatar_url_for('greenisus@gmail.com'), { :width => 80, :height => 80 }) %>    
  # link the avatar to some/url  <%= link_to(image_tag(gravatar_url_for 'greenisus@gmail.com'), 'some/url')%> 


end
