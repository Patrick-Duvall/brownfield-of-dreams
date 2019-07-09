# frozen_string_literal: true

class FriendsController < ApplicationController
  def create
    user = current_user
    friend = User.find_by(github_id: params['other_user_github_id'].to_i)
    user.friends.create!(friended_user: friend)
    redirect_to dashboard_path
  end
end
