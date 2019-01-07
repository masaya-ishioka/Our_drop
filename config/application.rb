require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module ToyApp2
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 5.2
    Refile.secret_key = 'c1bf751ac7423c1db6954653a32abc4f2dd024e45d1ecbca2f513c8e4f7469a45eb497ecb5134c70ae38a061718c49c677961a91574b1f293db83874a8288f1d'

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.
  end
end
