class UsersController < ApplicationController
  def index
    @users = User.all
  
    render({:template => "templates/index.html.erb"})
  end

end