# frozen_string_literal: true

class UserShowFacade
  def initialize(user)
    @user = user
  end

  def friends
    @user.reload
    @user.friended_users
  end

  def friended?(github_user)
    @user.reload
    friend = User.find_by(github_id: github_user.github_id)
    @user.friended_users.include?(friend) || github_user.no_account?
  end

  def repos
    parsed_response = service.repos
    parsed_response.map do |repo_data|
      Repo.new(repo_data)
    end
  end

  def followers
    parsed_response = service.followers
    parsed_response.map do |follower_data|
      GithubUser.new(follower_data)
    end
  end

  def following
    parsed_response = service.following
    parsed_response.map do |user_data|
      GithubUser.new(user_data)
    end
  end

  def bookmarked_videos
    @user.videos
  end

  private

  def service
    @service ||= GithubService.new(@user)
  end
end
