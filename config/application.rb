require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module UserRegistrationApplication
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.1
    if Rails.env.development?
      config.before_configuration do
        env_file = File.join(Rails.root,'.env')
        YAML.load(File.open(env_file)).split(' ').each do |ele|
          key = ele.split('=').first
          value = ele.split('=').last
          ENV[key.to_s] = value
        end if File.exists?(env_file)
      end
    end

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.
  end
end
