require "rails_helper"

RSpec.describe InviteMailer, type: :mailer do
  it "emails an invitation" do
    user = create(:user, github_name: 'tnodland')
    address = 'example@mail.com'
    expect(ActionMailer::Base.deliveries.count).to eq(0)
    email = InviteMailer.invite(user.github_name, address, 'testfreind').deliver_now
    expect(ActionMailer::Base.deliveries.count).to eq(1)
    expect(email.from).to eq(["sorrow@brownfield.com"])
    expect(email.to).to eq([address])
    expect(email.subject).to eq("#{user.github_name} has invited you to our site!")
    expect(email.body.encoded.include?("<a href=\"http://localhost:3000/register\">")).to eq(true)

    html_email = Capybara.string(email.body.encoded)

    expect(html_email).to have_link("here")
  end
end
