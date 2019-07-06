class UserShowFacade
  def initialize(user)
    @user = user
  end

  def repos
     parsed_response = service.get_repos
     repos = parsed_response.map do | repo_data|
      Repo.new(repo_data)
    end
  end

  def followed_user
    parsed_response = service.get_following
    parsed_response.map do |user_data|
      GithubUser.new(user_data)
    end
  end

  private

  def service
    @_service ||= GithubService.new(@user)
  end
end
