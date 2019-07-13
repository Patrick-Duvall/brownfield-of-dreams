# frozen_string_literal: true

require 'rails_helper'
require 'webmock_helper'

RSpec.describe 'invite page spec' do
  context 'as a registered user who has gone through the oauth process' do
    it 'can send an invite to a valid github handle' do
      user = create(:user, token: ENV['GITHUB_OAUTH_TOKEN'], github_name: 'tnodland')

      # As a registered user
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      # When I visit /dashboard
      visit dashboard_path
      # And I click "Send an Invite"
      click_link('Send an Invite')
      # Then I should be on /invite
      expect(current_path).to eq(invite_path)
      # And when I fill in "Github Handle" with <A VALID GITHUB HANDLE>
      fill_in 'q[Github Handle]', with: 'test-freind'
      # And I click on "Send Invite"
      click_on 'Send Invite'
      # Then I should be on /dashboard
      expect(current_path).to eq(dashboard_path)
      # And I should see a message that says "Successfully sent invite!" (if the user has an email address associated with their github account)
      expect(page).to have_content('Successfully sent invite!')
    end

    it 'cannot send an invite to an invalid github handle' do
      user = create(:user, token: ENV['GITHUB_OAUTH_TOKEN'], github_name: 'tnodland')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit invite_path

      fill_in 'q[Github Handle]', with: 'enfgisa;begs'
      click_on 'Send Invite'

      expect(page).to have_content('Invalid Github Handle, please try again')
    end
    it 'cannot invite a user with no associated email' do
      user = create(:user, token: ENV['GITHUB_OAUTH_TOKEN'], github_name: 'PatrickDuvall')
      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)
      visit invite_path

      fill_in 'q[Github Handle]', with: 'tnodland'
      click_on 'Send Invite'
      expect(page).to have_content('That user does not have an email account associated with their github.')
    end
  end
end
