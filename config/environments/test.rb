Activist::Application.configure do
  FACEBOOK_APP_ID = '155124928007541'
  FACEBOOK_APP_SECRET = '9b69b0cf2dc70ca931fb2646aff4f7dc'

  # Twilio's account credentials for testing
  ACCOUNT_SID = 'AC582454da60c53d2660fbff36042656e6'
  AUTH_TOKEN = 'fa4e593e6e396ecbac9d3fd33eba7b2f'
  APP_SID = 'AP123f795b7efddfd958bde327bc295def'

  DEFAULT_CLIENT = 'johnny'
  TWILIO_APP_URL = 'http://3vwj.localtunnel.com/'
  APP_ROOT_URL = 'http://localhost:3000/'
  SUNLIGHT_API_KEY = '5fc4caa80a7e4d2c9d9d1ab63bc96c3c'
  # Settings specified here will take precedence over those in config/application.rb

  # The test environment is used exclusively to run your application's
  # test suite. You never need to work with it otherwise. Remember that
  # your test database is "scratch space" for the test suite and is wiped
  # and recreated between test runs. Don't rely on the data there!
  config.cache_classes = true

  # Configure static asset server for tests with Cache-Control for performance
  config.serve_static_assets = true
  config.static_cache_control = "public, max-age=3600"

  # Log error messages when you accidentally call methods on nil
  config.whiny_nils = true

  # Show full error reports and disable caching
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Raise exceptions instead of rendering exception templates
  config.action_dispatch.show_exceptions = false

  # Disable request forgery protection in test environment
  config.action_controller.allow_forgery_protection    = false

  # Tell Action Mailer not to deliver emails to the real world.
  # The :test delivery method accumulates sent emails in the
  # ActionMailer::Base.deliveries array.
  config.action_mailer.delivery_method = :test

  # Raise exception on mass assignment protection for Active Record models
  config.active_record.mass_assignment_sanitizer = :strict

  # Print deprecation notices to the stderr
  config.active_support.deprecation = :stderr
end
