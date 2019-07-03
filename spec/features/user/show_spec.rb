require "rails_helper"

describe "as a user" do
  describe "when I visit my dashboard" do

    before :each do
      @user = create(:user, token: ENV["GITHUB_OAUTH_TOKEN"])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit dashboard_path
    end

    it "sees a github section with five repositorie links", :vcr do
      user_facade = UserShowFacade.new(@user)

      within ".github" do
        expect(page).to have_content("Github Repositories")
        expect(page.all(".repository").count).to eq(5)
        expect(page).to have_link(user_facade.repos[0].name)
        expect(page).to have_link(user_facade.repos[1].name)
      end
    end
    
  end

end
