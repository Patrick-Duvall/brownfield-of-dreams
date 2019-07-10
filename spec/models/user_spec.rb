# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    it { should validate_presence_of(:email) }
    it { should validate_presence_of(:first_name) }
    it { should validate_presence_of(:password) }
  end

  describe 'roles' do
    it 'can be created as default user' do
      user = User.create(email: 'user@email.com', password: 'password', first_name: 'Jim', role: 0)

      expect(user.role).to eq('default')
      expect(user.default?).to be_truthy
    end

    it 'can be created as an Admin user' do
      admin = User.create(email: 'admin@email.com', password: 'admin', first_name: 'Bob', role: 1)

      expect(admin.role).to eq('admin')
      expect(admin.admin?).to be_truthy
    end
  end
  describe "instance_methods" do
    it ".active?" do
      user1 = create(:user, active: false)
      user2 = create(:user, active: true)
      expect(user1.active?).to eq(false)
      expect(user2.active?).to eq(true)

    end
    it ".activate" do
      user = create(:user, active: false)
      user.activate
      expect(user.active?).to eq(true)

    end
  end
end
