class Mailer < ActionMailer::Base
  default to: 'info@zeit.io'

  def contact(sender, body, extra={})
    @sender = sender
    @body   = body
    @extra  = extra
    mail(from: @sender, subject: "[ContactForm]")
  end
end
