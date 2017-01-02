class User < ActiveRecord::Base
  has_one :account, as: :accountable
  has_many :posts

  def full_name
    "#{first_name} #{last_name}"
  end
end
