class UsersController < ApplicationController
  def new_registration_form
    render({:template => "/users/signup_form.html.erb"})
  end

  def user_sign_out
    reset_session

    @signed_in = false

    redirect_to("/", {:notice => "See ya later!"})

  end

  def user_sign_in

    render({:template => "/users/signin_form.html.erb"})
  end

  def authenticate
    email = params.fetch("input_email")

    password = params.fetch("input_password")

    user = User.where({:email => email}).at(0)

    if user == nil
      redirect_to("/user_sign_in", {:alert => "No one by that name around these parts!"})
    else
      if password == user.password
        session.store(:user_id, user.id)

        @signed_in = true

        redirect_to("/users", { :notice => "Welcome back, #{user.username}!"})
      else
        redirect_to("/user_sign_in", {:alert => "Incorrect password"})
      
      end
    end
  end
  
  
  
  def index
    @users = User.all.order({ :created_at => :desc })

    render({ :template => "users/index.html.erb" })
  end

  def show
    username = params.fetch("username")
    @user = User.where({:username => username}).at(0)

    render({ :template => "users/show.html.erb" })
  end

  def create
    @user = User.new
    @user.email = params.fetch("query_email")
    @user.comments_count = params.fetch("query_comments_count")
    @user.likes_count = params.fetch("query_likes_count")
    @user.is_private = params.fetch("query_is_private", false)
    @user.username = params.fetch("query_username")
    @user.password = params.fetch("query_password")

    if @user.valid?
      @user.save
      redirect_to("/users", { :notice => "User created successfully." })
    else
      redirect_to("/users", { :notice => "User failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    @user = User.where({ :id => the_id }).at(0)

    @user.email = params.fetch("query_email")
    @user.comments_count = params.fetch("query_comments_count")
    @user.likes_count = params.fetch("query_likes_count")
    @user.is_private = params.fetch("query_is_private", false)
    @user.username = params.fetch("query_username")
    @user.password = params.fetch("query_password")

    if @user.valid?
      @user.save
      redirect_to("/users/#{@user.id}", { :notice => "User updated successfully."} )
    else
      redirect_to("/users/#{@user.id}", { :alert => "User failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    @user = User.where({ :id => the_id }).at(0)

    @user.destroy

    redirect_to("/users", { :notice => "User deleted successfully."} )
  end
end
