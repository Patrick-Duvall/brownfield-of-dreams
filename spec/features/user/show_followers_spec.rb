# frozen_string_literal: true

require 'rails_helper'

describe 'as a user' do
  describe 'when I visit my dashboard' do
    it 'shows all followers in the github section of the page', :vcr do
      user = create(:user, token: ENV['GITHUB_OAUTH_TOKEN'])
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      user_facade = UserShowFacade.new(user)
      visit dashboard_path

      within '.github' do
        expect(page).to have_content('Github Followers')
        expect(page.all('.follower').count).to eq(3)
        expect(page).to have_link(user_facade.followers[0].name)
        expect(page).to have_link(user_facade.followers[1].name)
      end
    end
  end
end
