# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'As and admin user' do
  it 'can delete a tutorial and all associated videos' do
    admin = create(:user, role: 1)
    tutorial = create(:tutorial)
    create(:video, tutorial_id: tutorial.id)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(admin)

    visit admin_dashboard_path

    click_link 'Destroy'

    expect(current_path).to eq(admin_dashboard_path)

    expect(Tutorial.all.count).to eq(0)
    expect(Video.all.count).to eq(0)
  end
end
