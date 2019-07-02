class UserShowFacade
  def initialize(user)
    @user = user
  end

  def repos
    conn = Faraday.new("https://api.github.com/user/repos")  do |faraday|
      faraday.headers["Authorization"] = "token 44b8e0b87e1ec4a452b104ff098358450477aaa0"
      faraday.adapter Faraday.default_adapter
    end
    response = conn.get
    parsed_response = JSON.parse(response.body, symbolize_names: true)[0..4]
    repos = parsed_response.map do | repo_data|
      Repo.new(repo_data)
    end
  end
end
