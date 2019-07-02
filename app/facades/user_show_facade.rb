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

  private

  def service
    @_service ||= GithubService.new(@user)
  end
end
