class GithubUser
  attr_reader :github_name, :github_url
  
  def initialize(user_data)
    @github_name = user_data[:login]
    @github_url = user_data[:url]
  end
end
