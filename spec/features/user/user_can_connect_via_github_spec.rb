require "rails_helper"
require "webmock_helper"
describe "as a user" do
  describe "when I visit my dashboard" do


    after :each do
      OmniAuth.config.mock_auth[:github] = nil
    end

    it "I can connect via github" do
      # WebMock.allow_net_connect!
      OmniAuth.config.mock_auth[:github] = {
        'uid' => '1234',
        'info' => {
          'name' => 'mock_name'
        },
        'credentials' => {
          'token' => 'mock_token'
        }}
      user = create(:user, )
      user_facade = UserShowFacade.new(user)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit dashboard_path
      expect(page).to_not have_css(".github")
      click_link("Connect with GitHub")
      expect(current_path).to eq(dashboard_path)
      save_and_open_page
      expect(user.token).to eq('mock_token')
      expect(user.github_id.to_s).to eq('1234')
      expect(user.github_name).to eq('mock_name')
      expect(page).to have_css(".github")
    end
  end
end
