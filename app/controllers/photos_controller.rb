class PhotosController < ApplicationController
  def index
    @photos = Photo.all.order({ :created_at => :desc })

    render({ :template => "photos/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")
    @photo = Photo.where({:id => the_id }).at(0)

    @user = User.where({:id => @photo.owner_id}).at(0)

    render({ :template => "photos/show.html.erb" })
  end

  def create
    @photo = Photo.new
    @photo.caption = params.fetch("query_caption")
    @photo.owner_id = params.fetch("query_owner_id")
    @photo.image = params.fetch("query_image")
    @photo.likes_count = params.fetch("query_likes_count")
    @photo.comments_count = params.fetch("query_comments_count")

    if @photo.valid?
      @photo.save
      redirect_to("/photos", { :notice => "Photo created successfully." })
    else
      redirect_to("/photos", { :notice => "Photo failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    @photo = Photo.where({ :id => the_id }).at(0)

    @photo.caption = params.fetch("query_caption")
    @photo.owner_id = params.fetch("query_owner_id")
    @photo.image = params.fetch("query_image")
    @photo.likes_count = params.fetch("query_likes_count")
    @photo.comments_count = params.fetch("query_comments_count")

    if @photo.valid?
      @photo.save
      redirect_to("/photos/#{@photo.id}", { :notice => "Photo updated successfully."} )
    else
      redirect_to("/photos/#{@photo.id}", { :alert => "Photo failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("photo_id")
    @photo = Photo.where({ :id => the_id }).at(0)

    @photo.destroy

    redirect_to("/photos", { :notice => "Photo deleted successfully."} )
  end

  def like

    the_id = params.fetch("path_id")
    @photo = Photo.where({ :id => the_id }).at(0)


    @photo.likes_count = @photo.likes_count + 1

    @like = Like.new
    @like.fan_id = 0
    @like.photo_id = @photo.id
    
    if @like.valid?
      @like.save
    end

    if @photo.valid?
      @photo.save
      redirect_to("/photos/#{@photo.id}", { :notice => "Photo updated successfully."} )
    else
      redirect_to("/photos/#{@photo.id}", { :alert => "Photo failed to update successfully." })
    end
  end

  def unlike
    user_id = session.fetch(:user_id)

    the_id = params.fetch("path_id")
    @photo = Photo.where({ :id => the_id }).at(0)


    @photo.likes_count = @photo.likes_count - 1

    @like = Like.where({ :photo_id => @photo.id }).at(0)

    @like.destroy


    if @photo.valid?
      @photo.save
      redirect_to("/photos/#{@photo.id}", { :notice => "Photo updated successfully."} )
    else
      redirect_to("/photos/#{@photo.id}", { :alert => "Photo failed to update successfully." })
    end
  end

  def comment
    user_id = session.fetch(:user_id)

    the_id = params.fetch("path_id")
    @photo = Photo.where({ :id => the_id }).at(0)

    @comment = Comment.new
    @comment.body = params.fetch("Comment")
    @comment.author_id = user_id
    @comment.photo_id = @photo.id

    if @comment.valid?
      @comment.save
      redirect_to("/photos/#{@photo.id}", { :notice => "Photo updated successfully."} )
    else
      redirect_to("/photos/#{@photo.id}", { :alert => "Photo failed to update successfully." })
    end
  end



end
