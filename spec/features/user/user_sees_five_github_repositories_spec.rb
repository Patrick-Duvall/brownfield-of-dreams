# As a logged in user
# When I visit /dashboard
# Then I should see a section for "Github"
# And under that section I should see a list of 5 repositories with the name of each Repo linking to the repo on Github
require "rails_helper"

describe "as a user" do
  describe "when I visit my dashboard" do
    it "sees a github section with five repositorie links", :vcr do

      # require "pry"; binding.pry
      user = create(:user, token: ENV["GITHUB_OAUTH_TOKEN"])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit dashboard_path
      within ".github" do
        expect(page.all(".repository").count).to eq(5)
        #add more
      end

    end

  end

end
