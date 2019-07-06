require 'rails_helper'

RSpec.describe "as a logged in user with a github token" do
  context "when i visit my dashboard" do
    it "should see all of the people i follow on github", :vcr do
      user = create(:user, token: ENV['GITHUB_OAUTH_TOKEN'])
      user_facade = UserShowFacade.new(user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      within ".github" do
        expect(page).to have_content("Github Users You Follow")
        expect(page.all(".followed_user").count).to eq(2)
      end
    end
  end
end
