class Post < ActiveRecord::Base
  belongs_to :user
  validates_presence_of :user_id, :title, :body
  before_save :index_title, if: Proc.new { |post| post.user.public? }
  after_destroy :remove_index

  scope :published, -> { where(published: true) }
  scope :drafted, -> { where(draft: true) }
  scope :public_posts, -> { joins(:user).where("users.public = ?", true) }
  self.per_page = 8

  def index_title
    titles = Constant::POST_TITLES
    if new_record? && published
      titles << title
    elsif (published_was == false && published == true)
      titles = titles - [title_was] + [title]
    elsif (draft_was == false && draft == true)
      titles = titles - [title_was]
    elsif title != title_was && published
      titles = titles - [title_was] + [title]
    end
    Constant.const_set('POST_TITLES', titles)
  end

  def remove_index
    Constant.const_set('POST_TITLES', Constant::POST_TITLES - [title])
  end
end