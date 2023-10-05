require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Exavaichemi
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")

    Sidekiq::Options[:cron_poll_interval] = 60

    # Only do this if this is the server, not console for example
    if defined?(Rails::Server)
      config.after_initialize do
        # Only run this cron in production
        if Rails.env.production?
          Sidekiq::Cron::Job.create(name: "Update unicafe stats",
                                    cron: "30 4,9,10,15 * * * Europe/Helsinki", # 04:30, 09:30 etc
                                    class: UpdateUnicafeMenuJob)
        end
      end
    end
  end
end
