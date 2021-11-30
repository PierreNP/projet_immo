# Load the Rails application.
require_relative "application"
ActionMailer::Base.smtp_settings = {
  # :user_name => ENV['SENDGRID_LOGIN'],
  :user_name => 'apikey',
  :password => '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',
  :domain => 'heroku.com',
  :address => 'smtp.sendgrid.net',
  :port => 587,
  :authentication => :plain,
  :enable_starttls_auto => true
}
# Initialize the Rails application.
Rails.application.initialize!
