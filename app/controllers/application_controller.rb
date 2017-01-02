class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def content_not_found
    render file: "#{Rails.root}/public/404", layout: true, status: :not_found
  end

  def unauthorized
    # render file:
  end

  def current_user
    current_account.present? && current_account.user? ? current_account.accountable : nil
  end

  def verify_user
    if current_account.present?
      redirect_to root_path, flash: {error: 'You are not Admin bro!'} unless current_user
    else
      redirect_to new_account_session_path, flash: {error: 'Please Login to Continue..'}
    end
  end
end
