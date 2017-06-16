require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Sthinking
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
    config.action_mailer.smtp_settings = {
      address: "smtp.gmail.com",
      port: 587,
      domain: "structured-thinking.co.uk",
      user_name: "akiradeves@gmail.com",
      password: "!!!Nysoch1",
      authentication: :plain,
      enable_starttls_auto: true
    }

    config.action_mailer.default_url_options = {
      host: "localhost", port:3000
    }

    config.action_mailer.perform_deliveries = true
  end
end
