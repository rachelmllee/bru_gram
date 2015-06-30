class PhotosController < ApplicationController
  
  before_action :authenticate_user!, except: [:index]

  def index
      @photos = Photo.all
  end

  def show
      @user = current_user
      @photo = Photo.find(params[:id])
      author_id = @photo.user_id
      @author = User.find(author_id)
  end

  def new
      @user = current_user
      @photo = @user.photos.new
  end

  def edit
      @user = current_user
      @photo = @user.photos.find(params[:id])
  end

  def create
      @user = current_user
      @photo = @user.photos.build(photo_params)

      if @photo.save
        redirect_to user_photos_path(@user), notice: "Photo successfully created"
      else
        render 'new'
      end
  end

  def update
      @user = current_user
      @photo = @user.photos.find(params[:id])

      if @photo.update(photo_params)
        redirect_to user_photo_path(@user, @photo), notice: "Photo successfully updated"
      else
        render 'edit'
      end
  end

  def destroy
      @user = current_user
      @photo = @user.photos.find(params[:id])
      @photo.destroy
      redirect_to user_photos_path(@user), notice: "Photo successfully deleted"
    end

  private
      def photo_params
        params.require(:photo).permit(:name, :image_url, :caption, :public, :user_id)
      end
end