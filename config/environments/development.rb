Activist::Application.configure do
  FACEBOOK_APP_ID = '155124928007541'
  FACEBOOK_APP_SECRET = '9b69b0cf2dc70ca931fb2646aff4f7dc'
  ACCOUNT_SID = 'AC3ecb799e792404580fe5e903b88d3929'
  AUTH_TOKEN = 'd5ee548232ded22642dfe296d46df3af'
  APP_SID = 'AP123f795b7efddfd958bde327bc295def'
  DEFAULT_CLIENT = 'johnny'
  TWILIO_APP_URL = 'http://3bfi.localtunnel.com'
  APP_ROOT_URL = 'http://localhost:3000/'
  SUNLIGHT_API_KEY = '5fc4caa80a7e4d2c9d9d1ab63bc96c3c'

  # Settings specified here will take precedence over those in config/application.rb

  #allows devise to send emails in dev environment
  config.action_mailer.default_url_options = { :host => 'localhost:3000' }
  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Log error messages when you accidentally call methods on nil.
  config.whiny_nils = true


  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger
  config.active_support.deprecation = :log

  # Only use best-standards-support built into browsers
  config.action_dispatch.best_standards_support = :builtin

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Log the query plan for queries taking more than this (works
  # with SQLite, MySQL, and PostgreSQL)
  config.active_record.auto_explain_threshold_in_seconds = 0.5

  # Do not compress assets
  config.assets.compress = false

  # Expands the lines which load the assets
  config.assets.debug = true
end
