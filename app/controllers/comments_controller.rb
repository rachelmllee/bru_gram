class CommentsController < ApplicationController
  
  before_action :authenticate_user!

  # def index
  #     @photo = @photo.find(params[:photo_id])
  #     @comments = @photo.comments
  # end

  # def show
  #     @user = current_user
  #     @photo = @user.photos.find(params[:id])
  # end

  # def new
  #     @user = current_user
  #     @photo = @user.photos.new
  # end

  # def edit
  #     @user = current_user
  #     @photo = @user.photos.find(params[:id])
  # end

  def create
      @user = current_user
      @photo = Photo.find(params[:photo_id])
      @comment = @photo.comments.build(comment_params)
      @comment.user = @user
      @comment.save
      redirect_to photo_path(@photo)
  end

  # def update
  #     @user = current_user
  #     @photo = @user.photos.find(params[:id])

  #     if @photo.update(photo_params)
  #       redirect_to user_photo_path(@user, @photo), notice: "Photo successfully updated"
  #     else
  #       render 'edit'
  #     end
  # end

  def destroy
      @user = current_user
      @photo = Photo.find(params[:photo_id])
      @comment = @photo.comments.find(params[:id])
      @comment.destroy
      redirect_to photo_path(@photo), notice: "Comment successfully deleted"
    end

  private
      def comment_params
        params.require(:comment).permit(:body, :photo_id, :user_id)
      end
end