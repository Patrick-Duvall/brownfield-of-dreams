require 'rails_helper'

RSpec.describe Repo do
  context 'attributes' do
    it 'has the proper attributes' do
      repo_info = {
        :name => 'Trevor',
        :html_url => 'www.ebsite.com'
      }

      repo = Repo.new(repo_info)

      expect(repo.name).to eq('Trevor')
      expect(repo.url).to eq('www.ebsite.com')
    end
  end
end
