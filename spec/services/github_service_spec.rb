# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GithubService do
  before :each do
    @user = create(:user, token: ENV['GITHUB_OAUTH_TOKEN'])
  end

  it 'can get repositories', :vcr do
    service = GithubService.new(@user)
    repos = service.repos

    expect(repos.count).to eq(5)
    expect(repos[0]).to have_key(:id)
    expect(repos[0]).to have_key(:name)
    expect(repos[0]).to have_key(:full_name)
  end

  it 'can get users being followed', :vcr do
    service = GithubService.new(@user)
    users = service.following

    expect(users.count).to eq(2)
    expect(users[0]).to have_key(:login)
    expect(users[0]).to have_key(:id)
    expect(users[0]).to have_key(:html_url)
  end

  it 'can get followers', :vcr do
    service = GithubService.new(@user)
    users = service.followers

    expect(users.count).to eq(3)
    expect(users[0]).to have_key(:login)
    expect(users[0]).to have_key(:id)
    expect(users[0]).to have_key(:html_url)
  end
end
