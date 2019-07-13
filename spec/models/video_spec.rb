# frozen_string_literal: true

require 'rails_helper'
require "rake"

RSpec.describe Video, type: :model do
  context 'validations' do
    it 'ensures position cannot be nil' do
      should validate_presence_of(:position)
      expect(Video.create(position: nil).valid?).to eq(false)
    end

    it 'has a rake task to update nil position to valid position' do
      tutorial = create(:tutorial)
      vid = Video.create
      vid2 = tutorial.videos.create(position: 2)
      tutorial.videos << vid
      vid.position = nil
      allow(Video).to receive(:all).and_return([vid, vid2])
      rake = Rake.application
      rake.init
      rake.load_rakefile
      rake['videos:update_nil_position'].invoke
      expect(vid.position).to_not eq(nil)
      expect(Video.first).to eq(vid)
    end
  end
end
