module ApplicationHelper
  def full_title(page_title)
    base_title = "Test Blog"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def avatar(user, type)
    user.avatar_file_name.present? ? user.avatar.url(type) : image_url('default_user.png')
  end
end
