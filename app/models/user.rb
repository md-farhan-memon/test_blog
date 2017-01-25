class User < ActiveRecord::Base
  has_one :account, as: :accountable
  has_many :posts
  scope :public_profiles, -> { where(public: true) }
  acts_as_followable
  acts_as_follower

  def full_name
    "#{first_name} #{last_name}"
  end
end
