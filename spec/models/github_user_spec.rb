require 'rails_helper'

RSpec.describe GithubUser do
  before :each do
    @data_hash = {
      :id => 10,
      :login => 'tnodland',
      :html_url => 'www.ebsite.com'
    }
  end

  context "attributes" do
    it "has the proper attributes" do

      user = GithubUser.new(@data_hash)

      expect(user.github_id).to eq(10)
      expect(user.name).to eq('tnodland')
      expect(user.url).to eq('www.ebsite.com')
    end
  end

  context "methods" do
    it "can see if a user is authenticated" do
      data_hash2 = {
        :id => 11,
        :login => 'tnodland2',
        :html_url => 'www.ebsite1.com'
      }
      user1 = create(:user, github_id: 10)
      user2 = create(:user)
      github_user1 = GithubUser.new(@data_hash)
      github_user2 = GithubUser.new(data_hash2)

      expect(github_user1.no_account?).to eq(false)
      expect(github_user2.no_account?).to eq(true)
    end
  end
end
