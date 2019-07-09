# frozen_string_literal: true

RSpec.configure do |config|
  config.before :each do
    followers = File.read('fixtures/user_followers.json')
    following = File.read('fixtures/user_following.json')
    repos = File.read('fixtures/user_repos.json')
    stub_request(:get, 'https://api.github.com/user/repos')
      .to_return(status: 200, body: repos)
    stub_request(:get, 'https://api.github.com/user/followers')
      .to_return(status: 200, body: followers)
    stub_request(:get, 'https://api.github.com/user/following')
      .to_return(status: 200, body: following)
  end
end
