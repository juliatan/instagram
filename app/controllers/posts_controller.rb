class PostsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]

  def index
    # shows latest posts first
    @posts = Post.all.order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new post_params
    @post.user = current_user
    @post.save!
    redirect_to posts_path
  end

  def show
    @post = Post.find params[:id]
  end

  private

  def post_params
    params[:post].permit(:title, :description, :image, :tag_names, :address)
  end
end
