require "rails_helper"
require "webmock_helper"

describe "when " do
  it 'user can add a friend in' do
    user1 = create(:user, token: ENV['GITHUB_OAUTH_TOKEN'] )
    user2 = create(:user, github_id: nil)
    user3 = create(:user, github_id: 35322570, github_name: "Patrick-Duvall") #Patrick

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user1)

    visit dashboard_path
    within '.github-followers' do
      expect(page).to have_link("Add Patrick-Duvall to Friends")
      expect(page).to_not have_link("Add tnodland to Friends")
    end

    expect(user1.friends.count).to eq(0)
    within '.github-following' do
      click_link("Add Patrick-Duvall to Friends")
    end
    expect(current_path).to eq(dashboard_path)
    save_and_open_page
    expect(user1.friends.count).to eq(1)

    within '.friends' do
      expect(page).to have_content(user3.github_name)
    end

    within '.github-followers' do
      expect(page).to_not have_link("Add Patrick-Duvall to Friends")
    end

    within '.github-following' do
      expect(page).to_not have_link("Add Patrick-Duvall to Friends")
    end
  end
end
