class UserController < ApplicationController
  before_action :verify_user, except: [:show]

  def show
    if @user = User.find_by_id(params[:id])
      @posts = @user.posts.published.order('posts.views desc').limit(3)
      @follower, @can_follow = (current_user.present? ? current_user.following?(@user) : false), current_user.blank? ? true : current_user.id != @user.id
    else
      content_not_found
    end
  end

  def edit
    @user = current_user
  end

  def update
    params[:public] = params[:public] == 'on' ? true : false
    if current_user.update_attributes(user_params)
      flash[:success] = "Profile Updated Succesfully"
    else
      flash[:error] = "Error Updating Profile"
    end
    redirect_to edit_user_path
  end

  def follow
    user = User.find_by_id(params[:user_id])
    current_user.follow(user) if user.present?
    redirect_to user_path(params[:user_id])
  end

  def unfollow
    user = User.find_by_id(params[:user_id])
    current_user.stop_following(user) if user && current_user.following?(user)
    redirect_to user_path(params[:user_id])
  end

  def delete_avatar
    current_user.update_attribute(:avatar, nil)
    redirect_to edit_user_path
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :dob, :gender, :public, :avatar)
  end
end