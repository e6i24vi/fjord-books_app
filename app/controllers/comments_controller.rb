# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]

  # GET /comments/1/edit
  def edit
    @comment = current_user.comments.find(params[:id])
  end

  # POST /comments or /comments.json
  def create
    @comment = @commentable.comments.build(comment_params.merge(user: current_user))
    if @comment.save
      redirect_to [@commentable], notice: I18n.t('comments.create.notice')
    else
      render :new
    end
  end

  # PATCH/PUT /comments/1 or /comments/1.json
  def update
    @comment = current_user.comments.find(params[:id])
    @comment.update(comment_params)
    redirect_to [@commentable], notice: t('comments.update.notice')
  end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    if @comment.user_id != current_user.id
      redirect_to [@commentable]
    else
      @comment.destroy
      redirect_to [@commentable], notice: t('comments.destroy.notice')
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def set_comments
    raise NotImplementedError
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
