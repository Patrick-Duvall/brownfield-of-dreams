class GithubService

  def initialize(user)
    @user = user
  end

  def get_repos
    response = conn.get('/user/repos')
    parsed_response = JSON.parse(response.body, symbolize_names: true)[0..4]
  end

  def get_followers
    response = conn.get('/user/followers')
    parsed_response = JSON.parse(response.body, symbolize_names: true)
  end

  private

  def conn
    @_conn ||= Faraday.new("https://api.github.com")  do |faraday|
      faraday.headers["Authorization"] = "token #{@user.token}"
      faraday.adapter Faraday.default_adapter
    end
  end

end
