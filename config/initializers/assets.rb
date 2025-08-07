# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

Rails.application.config.assets.paths << Rails.root.join("node_modules/bootstrap-icons/font")
Rails.application.config.assets.paths << Rails.root.join("node_modules/bootstrap/dist/js")
Rails.application.config.assets.precompile += %w(bootstrap.min.js popper.js)
# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path
Rails.application.config.assets.paths << Rails.root.join('node_modules/openseadragon/build/openseadragon/images')
Rails.application.config.assets.paths << Rails.root.join("node_modules/@fortawesome/fontawesome-free/webfonts")
# Blacklight Allmaps
Rails.application.config.assets.paths << Rails.root.join('node_modules')
Rails.application.config.assets.paths << Rails.root.join('vendor', 'assets', 'images')
Rails.application.config.assets.precompile += %w( blacklight/allmaps/allmaps-logo.svg )
# Rails.application.config.assets.paths << Blacklight::Allmaps::Engine.root.join("app/javascript")
# Rails.application.config.importmap.cache_sweepers << Blacklight::Allmaps::Engine.root.join('app/javascript')
