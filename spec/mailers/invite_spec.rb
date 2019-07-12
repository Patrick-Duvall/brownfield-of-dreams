# frozen_string_literal: true

require 'rails_helper'

RSpec.describe InviteMailer, type: :mailer do
  it 'emails an invitation' do
    user = create(:user, github_name: 'tnodland')
    address = 'example@mail.com'

    email = InviteMailer.invite(user.github_name, address, 'testfreind')

    expect { email.deliver_now }.to change { ActionMailer::Base.deliveries.count }.by(1)

    sent_email = email.deliver_now

    expect(sent_email.from).to eq(['sorrow@brownfield.com'])
    expect(sent_email.to).to eq([address])
    expect(sent_email.subject).to eq("#{user.github_name} has invited you to our site!")
    expect(sent_email.body.encoded.include?('<a href="http://localhost:3000/register">')).to eq(true)

    html_email = Capybara.string(sent_email.body.encoded)

    expect(html_email).to have_link('here')
  end
end
