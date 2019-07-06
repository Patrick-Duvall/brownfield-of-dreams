class UserShowFacade
  def initialize(user)
    @user = user
  end

  def repos
     parsed_response = service.get_repos
     # require "pry"; binding.pry
     repos = parsed_response.map do | repo_data|
      Repo.new(repo_data)
    end
  end
  def followers
    parsed_response = service.get_followers
    followers = parsed_response.map do | follower_data|
     GithubUser.new(follower_data)
   end
  end

  def followed_user
    parsed_response = service.get_following
    parsed_response.map do |user_data|
      GithubUser.new(user_data)
    end
  end

  def bookmarked_videos
    @user.videos
  end

  private

  def service
    @_service ||= GithubService.new(@user)
  end
end
