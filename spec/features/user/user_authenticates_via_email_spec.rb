# frozen_string_literal: true

require 'rails_helper'
require 'webmock_helper'

describe 'As a visitor' do
  it 'when I regiter, prompts me to activate my account by email' do
    visit '/'
    click_link 'Register'
    expect(current_path).to eq(register_path)

    fill_in 'user_email', with: 'email'
    fill_in 'user_first_name', with: 'first_name'
    fill_in 'user_last_name', with: 'last_name'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    expect { click_button 'Create Account' }
      .to change { ActionMailer::Base.deliveries.count }.by(1)
    user = User.last
    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('Logged in as first_name last_name')
    expect(page).to have_content('This account has not yet been activated. Please check your email')
    expect(user.active?).to eq(false)
    expect(page).to have_content('Status: Inactive')
    # Email view logic part in mailer/activation_spec.rb
    visit user_activation_path(user)
    user.reload
    expect(current_path).to eq(dashboard_path)
    expect(page).to have_content('Thank you! Your account is now activated.')
    expect(page).to have_content('Status: Active')
    expect(user.active?).to eq(true)
  end
end

# As a guest user
# When I visit "/"
# And I click "Register"
# Then I should be on "/register"
# And when I fill in an email address (required)
# And I fill in first name (required)
# And I fill in first name (required)
# And I fill in password and password confirmation (required)
# And I click submit
# Then I should be redirected to "/dashboard"
# And I should see a message that says "Logged in as <SOME_NAME>"
# And I should see a message that says "This account has not yet been activated. Please check your email."
