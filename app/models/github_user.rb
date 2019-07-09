# frozen_string_literal: true

class GithubUser
  attr_reader :name, :url, :github_id
  def initialize(follower_info)
    @github_id = follower_info[:id]
    @name = follower_info[:login]
    @url = follower_info[:html_url]
  end

  def no_account?
    User.find_by(github_id: @github_id).nil?
  end
end
