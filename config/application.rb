# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Maido
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
    # config.web_console.whitelisted_ips = '0.0.0.0/0'

    # config.middleware.insert_before 0, Rack::Cors do
    #   allow do
    #     origins "*"
    #     resource "*",
    #       headers: :any,
    #       methods: [:get, :post, :put, :options, :head]
    #   end
    # end
    config.action_dispatch.default_headers = {
      'Access-Control-Allow-Credentials' => 'true',
      'Access-Control-Allow-Origin' => '*',
      'Access-Control-Request-Method' => '*'
    }
  end
end
