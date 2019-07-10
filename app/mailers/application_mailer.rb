# frozen_string_literal: true

class ApplicationMailer < ActionMailer::Base
  default from: 'sorrow@brownfield.com'
  layout 'mailer'
end
