class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.all.page(params[:page])
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to new_post_path
    else
      render :new
    end
  end

  def new
    @post = Post.new
    @posts = Post.all
  end

  def show
    @post = Post.find(params[:id])
  end

  def update
    @post = Post.find(params[:id])
    if @post.user != current_user
      redirect_to posts_path
    else
      if @post.update(post_params)
        redirect_to posts_path
      else
        render :edit
      end
    end
  end

  def edit
    @post = Post.find(params[:id])
  end

  def destroy
    @post = Post.find(params[:id])
    if @post.user !=current_user
      redirect_to posts_path
    else
      @post.destroy
      redirect_to posts_path
    end

  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
