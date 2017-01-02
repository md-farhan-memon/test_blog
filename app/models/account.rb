class Account < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  belongs_to :accountable, polymorphic: true

  def admin?
    accountable_type == 'Admin'
  end

  def user?
    accountable_type == 'User'
  end
end
