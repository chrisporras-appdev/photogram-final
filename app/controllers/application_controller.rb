class ApplicationController < ActionController::Base
  def index
  
    render({:template => "templates/index.html.erb"})
  end
  

end
