require 'rails_helper'

RSpec.describe Video, type: :model do
  context 'validations' do
    it 'ensures position cannot be nil' do
       should validate_presence_of(:position)
       expect(Video.create(position: nil).valid?).to eq(false)
      end

      it "can update nil position to valid position" do
        vid = Video.create
        vid.position = nil
        allow(Video).to receive(:all).and_return([vid])
        Video.update_positions
        expect(vid.position).to_not eq(nil)
        expect(Video.first).to eq(vid)
      end

  end

end
