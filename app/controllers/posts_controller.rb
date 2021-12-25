# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!

  def index
    @posts = Post.all.page(params[:page])
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      redirect_to posts_path, notice: t('posts.create.notice')
    else
      render :new
    end
  end

  def new
    @post = Post.new
    @posts = Post.all.page(params[:page])
  end

  def show
    @post = Post.includes(comments: :user).find(params[:id])
  end

  def update
    @post = current_user.posts.find(params[:id])
    if @post.update(post_params)
      redirect_to posts_path, notice: t('posts.update.notice')
    else
      render :edit
    end
  end

  def edit
    @post = current_user.posts.find(params[:id])
  end

  def destroy
    @post = current_user.posts.find(params[:id])
    @post.destroy!
    redirect_to posts_path, notice: t('posts.destroy.notice')
  end

  private

  def post_params
    params.require(:post).permit(:title, :body)
  end
end
