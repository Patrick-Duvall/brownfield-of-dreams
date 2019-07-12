# frozen_string_literal: true

RSpec.configure do |config|
  config.before :each do
    followers = File.read('fixtures/user_followers.json')
    following = File.read('fixtures/user_following.json')
    repos = File.read('fixtures/user_repos.json')
    single_user = File.read('fixtures/single_user.json')
    single_user_no_email = File.read('fixtures/single_user_no_email.json')
    not_found = File.read('fixtures/not_found.json')
    stub_request(:get, 'https://api.github.com/user/repos')
      .to_return(status: 200, body: repos)
    stub_request(:get, 'https://api.github.com/user/followers')
      .to_return(status: 200, body: followers)
    stub_request(:get, 'https://api.github.com/user/following')
      .to_return(status: 200, body: following)
    stub_request(:get, 'https://api.github.com/users/test-freind')
      .to_return(status: 200, body: single_user)
    stub_request(:get, 'https://api.github.com/users/enfgisa;begs')
      .to_return(status: 200, body: not_found)
    stub_request(:get, 'https://api.github.com/users/tnodland')
      .to_return(status: 200, body: single_user_no_email)
  end
end
