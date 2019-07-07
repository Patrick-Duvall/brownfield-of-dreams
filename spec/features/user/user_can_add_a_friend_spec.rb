require "rails_helper"
require "webmock_helper"

describe "when " do
  it 'user can sign in' do
    user1 = create(:user, token: ENV['GITHUB_OAUTH_TOKEN'] )
    user2 = create(:user, github_id: nil)
    user3 = create(:user, github_id: 35322570) #Patrick

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

    visit dashboard_path

    within '.followers' do
      expect(page).to have_link("Add Patrick-Duvall to Followers")
    end

    expect(user1.friends.count).to eq(0)
    within '.following' do
      click_link("Add Patrick-Duvall to Followers")
    end
    expect(current_path).to eq(dashboard_path)
    expect(user1.friends.count).to eq(1)

    within '.friends' do
      expect(page).to have_content("Patrick-Duvall")
    end

    within '.followers' do
      expect(page).to_not have_link("Add Patrick-Duvall to Followers")
    end

    within '.following' do
      expect(page).to_not have_link("Add Patrick-Duvall to Followers")
    end
  end
end
