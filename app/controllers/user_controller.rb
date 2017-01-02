class UserController < ApplicationController
  before_action :verify_user

  def edit
    @user = current_user
  end

  def update
    if current_user.update_attributes(user_params)
      flash[:success] = "Profile Updated Succesfully"
    else
      flash[:error] = "Error Updating Profile"
    end
    redirect_to edit_user_path
  end

  private

  def user_params
    params.permit(:first_name, :last_name, :dob, :gender)
  end
end