require "mandrill"

class ApplicationMailer < ActionMailer::Base
  default(
    from: "hello@example.com",
    reply_to: "hello@example.com"
  )
  layout 'mailer'

  private

  def send_mail(email, subject, body)
    mail(to: email, subject: subject, body: body, content_type: "text/html")
  end

  def mandrill_template(template_name, attributes)
    mandrill = Mandrill::API.new(ENV["SMTP_PASSWORD"])

    merge_vars = attributes.map do |key, value|
      { name: key, content: value }
    end

    mandrill.templates.render(template_name, [], merge_vars)["html"]
  end
end