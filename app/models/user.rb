class User < ActiveRecord::Base
  has_one :account, as: :accountable
  has_many :posts
  scope :public_profiles, -> { where(public: true) }
  acts_as_followable
  acts_as_follower

  has_attached_file :avatar,
  path: ":rails_root/public/system/:attachment/:id/:basename_:style.:extension",
  url: "/system/:attachment/:id/:basename_:style.:extension",
  styles: {
    thumb: ['60x60#',  :jpg, :quality => 70],
    large: ['120x120#',  :jpg, :quality => 70]
  },
  convert_options: {
    thumb: '-set colorspace sRGB -strip',
    large: '-set colorspace sRGB -strip -sharpen 0x0.5'
  }

  validates_attachment :avatar,
    :size => { :in => 0..5.megabytes },
    :content_type => { :content_type => /^image\/(jpeg|png|gif|tiff)$/ }

  def full_name
    "#{first_name} #{last_name}"
  end
end
