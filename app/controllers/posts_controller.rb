class PostsController < ApplicationController

  before_action :verify_user, except: [:index, :show, :search, :published]
  before_action :set_post_if_valid, only: [:edit, :update, :destroy]
  before_action :set_type, only: [:create, :update]
  before_action :set_sort, only: [:index, :published, :search]
  after_action :update_view_count, only: [:show]

  def index
    @posts = Post.published.public_posts.includes(:user).page(params[:page]).order(@sort)
  end

  def new
    @post = current_user.posts.new
  end

  def create
    @post = current_user.posts.create(post_params)
    if @post.id
      set_redirection
    else
      flash[:error] = "Error Creating Post"
      render :new
    end
  end

  def drafts
    @posts = current_user.posts.drafted.page(params[:page]).order('created_at desc')
  end

  def published
    if (user = User.find_by_id(params[:id])).present?
      @posts = user.posts.published.page(params[:page]).order(@sort)
      render :index
    else
      content_not_found
    end
  end

  def show
    if @post = Post.includes(:user).find_by_id(params[:id])
      redirect_to user_path(@post.user) unless @post.user.public? || (current_user.present? && current_user.id == @post.user_id) || (current_user.present? && current_user.following?(@post.user))
    else
      content_not_found
    end
  end

  def update
    if @post.update_attributes(post_params)
      set_redirection
    else
      flash[:error] = "Error Saving Post"
      redirect_to edit_post_path(@post) and return
    end
  end

  def destroy
    if @post.destroy
      flash[:notice] = "Successfully deleted post!"
      redirect_to published_posts_path(current_account.accountable) and return
    else
      flash[:alert] = "Error updating post!"
    end
  end

  def search
    @posts = Post.published.where("title iLIKE ?", "%#{params[:query]}%").includes(:user).page(params[:page]).order(@sort)
    redirect_to post_path(@posts.first) and return if @posts.count == 1
    render :index
  end

  private

  def post_params
    params.require(:post).permit(:title, :body, :draft, :published)
  end

  def set_post_if_valid
    if (post = Post.find_by_id(params[:id]))
      if post.user_id == current_user.id
        @post = post
      else
        # ToDo: Unauthorized
      end
    else
      content_not_found
    end
  end

  def set_type
    if params[:commit] == "Publish"
      params[:post][:published] = true
      params[:post][:draft] = false
    else
      params[:post][:published] = false
      params[:post][:draft] = true
    end
  end

  def set_redirection
    if post_params[:published]
      flash[:notice] = "Posted Successfully"
      redirect_to post_path(@post) and return
    else
      flash[:notice] = "Draft saved Successfully"
      redirect_to edit_post_path(@post) and return
    end
  end

  def set_sort
    @sort = params[:sort] == 'Sort by Popularity' ? 'posts.views desc' : 'posts.created_at desc'
  end

  def update_view_count
    @post.increment!(:views) if @post.published?
  end

end