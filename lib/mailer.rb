class Mailer < ActionMailer::Base
  default to: 'info@zeit.io'

  def contact(sender, body, extra={})
    @sender = sender
    @body   = body
    @extra  = extra
    @cc     = ["your-mail@example.com", "your-second-mail@example.com"]
    mail(from: @sender, subject: "[ContactForm]", cc: @cc)
  end
end
