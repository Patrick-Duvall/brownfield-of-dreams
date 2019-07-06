require 'rails_helper'

RSpec.describe "As a logged in user" do
  context "on my dashboard" do
    it "should see all bookmarked videos" do
      user = create(:user)
      tutorial = create(:tutorial)
      video1 = create(:video, tutorial: tutorial)
      video2 = create(:video, tutorial: tutorial)
      UserVideo.create(user: user, video: video1)
      UserVideo.create(user: user, video: video2)
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit dashboard_path

      within ".bookmarked-videos" do
        expect(page).to have_content("Bookmarked Segments")
        expect(page.all(".bookmarked_video").count).to eq(2)
        expect(page.all(".bookmarked_video")[0]).to have_link(video1.title)
        expect(page.all(".bookmarked_video")[1]).to have_link(video2.title)
      end
    end
  end
end
