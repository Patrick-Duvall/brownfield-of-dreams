class InviteMailer < ApplicationMailer
  def invite(sender_name, invitee_email, invitee_name)
    @sender_name = sender_name
    @invitee_name = invitee_name
    mail(to: invitee_email, subject: "#{sender_name} has invited you to our site!")
  end
end
