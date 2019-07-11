require "rails_helper"



  describe ActivationMailer do
    it "checks email content" do
      user = create(:user)
      email = ActivationMailer.activate(user, user.email).deliver_now
      expect(email.from).to eq(["sorrow@brownfield.com"])
      expect(email.to).to eq([user.email])
      expect(email.subject).to eq("Welcome to Sorrow #{user.first_name}.")

      expect(email.body.encoded.include?("<a href=\"http://localhost:3000/user/activation/#{user.id}\">")).to eq(true)
      html_email = Capybara.string(email.body.encoded)

      expect(html_email).to have_link("Click here to activate your account")
    end

  end
