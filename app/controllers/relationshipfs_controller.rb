# frozen_string_literal: true

class RelationshipfsController < ApplicationController
  def create
    following = current_user.relationshipfs.build(follower_id: params[:user_id])
    following.save!
    redirect_to request.referer || root_path
  end

  def destroy
    following = current_user.relationshipfs.find_by!(follower_id: params[:user_id])
    following.destroy!
    redirect_to request.referer || root_path
  end
end
