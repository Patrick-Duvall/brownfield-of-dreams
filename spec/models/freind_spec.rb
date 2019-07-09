require 'rails_helper'

RSpec.describe Friend do
  context "relationships" do
    it { should belong_to(:user) }
    it { should belong_to(:friended_user) }
  end
end
