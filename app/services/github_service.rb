# frozen_string_literal: true

class GithubService
  def initialize(user)
    @user = user
  end

  def repos
    response = conn.get('/user/repos')
    JSON.parse(response.body, symbolize_names: true)[0..4]
  end

  def following
    response = conn.get('/user/following')
    JSON.parse(response.body, symbolize_names: true)
  end

  def followers
    response = conn.get('/user/followers')
    JSON.parse(response.body, symbolize_names: true)
  end

  private

  def conn
    Faraday.new('https://api.github.com') do |faraday|
      faraday.headers['Authorization'] = "token #{@user.token}"
      faraday.adapter Faraday.default_adapter
    end
  end
end
