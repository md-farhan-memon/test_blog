class Constant
  POST_TITLES = Post.published.pluck(:title) if ActiveRecord::Base.connection.tables.include?('posts')
end