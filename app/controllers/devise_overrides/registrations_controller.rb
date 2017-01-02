class DeviseOverrides::RegistrationsController < Devise::RegistrationsController
  def create
    super do |resource|
      user = User.where(email: resource.email).first_or_initialize
      user.save
      resource.update_attributes(accountable: user)
    end
  end
end