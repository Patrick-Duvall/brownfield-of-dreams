require 'rails_helper'

RSpec.describe Video, type: :model do
  context 'validations' do
    it 'ensures position cannot be nil' do
       should validate_presence_of(:position)
       expect(Video.create(position: nil).valid?).to eq(false)
      end

  end

end
