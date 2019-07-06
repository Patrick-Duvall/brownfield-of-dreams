class GithubUser
  attr_reader :name, :url
  def initialize(follower_info)
    @name = follower_info[:name]
    @url = follower_info[:html_url]
  end
end
