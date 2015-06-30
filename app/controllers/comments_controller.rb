class CommentsController < ApplicationController
  
  before_action :authenticate_user!

  def edit
      @photo = Photo.find(params[:photo_id])
      @comment = @photo.comments.find(params[:id])
  end

  def create
      @user = current_user
      @photo = Photo.find(params[:photo_id])
      @comment = @photo.comments.build(comment_params)
      @comment.user = @user
      @comment.save
      redirect_to photo_path(@photo)
  end

  def update
      @photo = Photo.find(params[:photo_id])
      @comment = @photo.comments.find(params[:id])

      if @comment.update(comment_params)
        redirect_to photo_path(@photo)
      else
          render 'comments/edit'
      end
  end

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