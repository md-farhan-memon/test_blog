class Constant
  POST_TITLES = Post.published.public_posts.pluck(:title) if ActiveRecord::Base.connection.tables.include?('posts')
end