class Mailer < ActionMailer::Base
  default to: 'info@zeit.io'

  def contact(sender, body, extra={})
    @sender = sender
    @body   = body
    @extra  = extra
    @cc     = ["pm@zeit.io", "sp@zeit.io"]
    mail(from: @sender, subject: "[ContactForm]", cc: @cc)
  end
end
