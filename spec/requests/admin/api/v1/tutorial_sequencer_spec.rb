require "rails_helper"
describe "TutorialSequencer" do
  it 'disallows non-admins' do
    tutorial1 = create(:tutorial)
    tutorial2 = create(:tutorial)

    video1 = create(:video, tutorial_id: tutorial1.id)
    video2 = create(:video, tutorial_id: tutorial1.id)
    create_list(:video, 2, tutorial_id: tutorial2.id)

    expect{put "/admin/api/v1/tutorial_sequencer/#{tutorial1.id}"}.to raise_error(ActionController::RoutingError)
  end

  it "sequences for admins" do
    admin = create(:user, role: 'admin')
    tutorial1 = create(:tutorial)
    tutorial2 = create(:tutorial)

    video1 = create(:video, tutorial_id: tutorial1.id)
    video2 = create(:video, tutorial_id: tutorial1.id)
    create_list(:video, 2, tutorial_id: tutorial2.id)
    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)
    allow_any_instance_of(User).to receive(:admin?).and_return(true)
    require "pry"; binding.pry

    put "/admin/api/v1/tutorial_sequencer/#{tutorial1.id}"

    expect(response).to be_successful

    parsed = JSON.parse(response.body, symbolize_names: true)

    expect(parsed[:id]).to eq(tutorial1.id)
    expect(parsed[:videos].first[:id]).to eq(video1.id)
    expect(parsed[:videos].last[:id]).to eq(video2.id)
  end
end
