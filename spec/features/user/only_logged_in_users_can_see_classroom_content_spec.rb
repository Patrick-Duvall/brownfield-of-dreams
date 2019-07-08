
require "rails_helper"
require "webmock_helper"

describe "only logged in users can see classroom content" do
  before :each do
    @class_tutorial = create(:tutorial, classroom: true)
    @class_video = create(:video)
    @class_tutorial.videos << @class_video
    @free_tutorial = create(:tutorial)
    @non_class_video = create(:video)
    @free_tutorial.videos << @non_class_video
    @user = create(:user)
  end
  describe "as a user" do
    it "lets me see vidoes that are classroom content" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
      visit tutorial_path(@class_tutorial)
      expect(page).to have_content(@class_video.title)
      expect(page).to have_content("Description")
      visit tutorial_path(@free_tutorial)
      expect(page).to have_content(@non_class_video.title)
      expect(page).to have_content("Description")
    end
  end

  describe "as a visitor" do
    it "does not let me see classroom content" do
      visit tutorial_path(@class_tutorial)
      expect(page).to_not have_content(@class_video.title)
      expect(page).to_not have_content("Description")
      visit tutorial_path(@free_tutorial)
      expect(page).to have_content(@non_class_video.title)
      expect(page).to have_content("Description")
    end
  end

end
