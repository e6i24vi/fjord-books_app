# frozen_string_literal: true

class FollowingrelationshipsController < ApplicationController
  def create
    following = current_user.followingrelationships.build(follower_id: params[:user_id])
    following.save!
    redirect_to user_path(params[:user_id])
  end

  def destroy
    following = current_user.followingrelationships.find_by!(follower_id: params[:user_id])
    following.destroy!
    redirect_to user_path(params[:user_id])
  end
end
