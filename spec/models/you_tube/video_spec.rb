# frozen_string_literal: true

require 'rails_helper'

RSpec.describe YouTube::Video do
  before :each do
    @video_data = {
      items: [
        {
          snippet: {
            thumbnails: {
              high: {
                url: 'www.ebsite.com'
              }
            }
          }
        }
      ]
    }
  end

  context 'attributes' do
    it 'has proper attribute' do
      video = YouTube::Video.new(@video_data)

      expect(video.thumbnail).to eq('www.ebsite.com')
    end
  end
end
