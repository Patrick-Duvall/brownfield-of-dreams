# Currently all tutorials are visible to anyone. We want to make tutorials marked as "classroom content" viewable only if the user is logged in.
#
# The tutorials table has a boolean column for classroom that should be used for this story.

require "rails_helper"
require "webmock_helper"

describe "only logged in users can see classroom content" do
  before :each do
    @class_tutorial = create(:tutorial, classroom: true)
    @class_video = create(:video)
    @class_tutorial.videos << @class_video
    @free_tutorial = create(:tutorial, classroom: true)
    @non_class_video = create(:video)
    @free_tutorial.videos << @non_class_video
    @user = create(:user)
  end
  describe "as a user" do
    it "lets me see vidoes that are classroom content" do
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
      visit tutorial_path(@class_tutorial)
      expect(page).to have_content(@class_video.title)
    end
  end

  describe "as a visitor" do
    it "does not let me see classroom content" do
      visit tutorial_path(@class_tutorial)
      save_and_open_page
      expect(page).to_not have_content(@class_video.title)
    end
  end

end
