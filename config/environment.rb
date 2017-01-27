# Load the Rails application.
require File.expand_path('../application', __FILE__)

# Initialize the Rails application.
Rails.application.initialize!

# Mailer

# ActionMailer::Base.smtp_settings = {
#   address: "smtp.gmail.com",
#   port: 587,
#   domain: "gmail.com",
#   authentication: "plain",
#   enable_starttls_auto: true,
#   openssl_verify_mode: 'none',
#   user_name: ENV["GMAIL_USERNAME"],
#   password: ENV["GMAIL_PASSWORD"]
# }