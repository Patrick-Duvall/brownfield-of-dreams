# frozen_string_literal: true

require 'rails_helper'
describe TutorialFacade do
  describe 'instance methods' do
    before :each do
      @user = create(:user)
      @tutorial = create(:tutorial)
      @video1 = create(:video, tutorial_id: @tutorial.id)
      @video2 = create(:video, tutorial_id: @tutorial.id)
      @video3 = create(:video, tutorial_id: @tutorial.id)
    end
    it 'can find the current video' do
      presenter = TutorialFacade.new(@tutorial, @user, @video2.id)
      expect(presenter.current_video.id).to eq(@video2.id)
    end

    it 'uses first video if video id not present' do
      presenter = TutorialFacade.new(@tutorial, @user)
      expect(presenter.current_video.id).to eq(@video1.id)
    end

    context '#next_video' do
      it 'can find the next video' do
        presenter = TutorialFacade.new(@tutorial, @user, @video1.id)
        expect(presenter.next_video).to eq(@video2)
      end

      it 'returns the last video if the current video is the last in the list' do
        learn_to_fight = create(:tutorial)
        create(:video, tutorial: learn_to_fight, position: 1)
        bloodsport = create(:video, tutorial: learn_to_fight, position: 2)

        presenter = TutorialFacade.new(learn_to_fight, @user, bloodsport.id)
        expect(presenter.next_video).to eq(bloodsport)
      end
    end
  end
end
