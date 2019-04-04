require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Lifeproject
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    config.assets.enabled = true

    config.assets.paths << Rails.root.join("app", "assets", "img")
    config.assets.paths << Rails.root.join("app", "assets", "stylesheets", "font")
    #config.assets.paths << Rails.root.join("app", "assets", "adminlte")
    #comentado, utilizando agora pelo modulo npm/node
    #commented, it is using now through npm/node
    #17/10/18

    config.i18n.default_locale = 'pt-BR'
    config.time_zone = 'Brasilia'
    config.i18n.available_locales = ["en", "pt-BR"]
    #added a new folder to separate the name of the languages
    config.i18n.load_path += Dir["#{Rails.root.to_s}/config/locales/languages/*.yml"]
    #config.i18n.load_path += Dir["#{Rails.root.to_s}/config/locales/**/*.{rb,yml}"]


    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.


    #configuration for the database and other info
    config.before_configuration do
      env_file = File.join(Rails.root, 'config', 'application.yml')
      YAML.load(File.open(env_file)).each do |key, value|
        ENV[key.to_s] = value
      end if File.exists?(env_file)
    end

  end
end
