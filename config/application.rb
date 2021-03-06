require_relative "boot"

require "rails/all"

Bundler.require(*Rails.groups)

module Askme
  class Application < Rails::Application
    config.load_defaults 6.1

    config.time_zone = 'Moscow'
    config.i18n.default_locale = :ru
    config.i18n.fallbacks = [:en]
  end
end
