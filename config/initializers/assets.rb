# Be sure to restart your server when you modify this file.

# Version of your assets, change this if you want to expire all your assets.
Rails.application.config.assets.version = "1.0"

# Add additional assets to the asset load path.
# Rails.application.config.assets.paths << Emoji.images_path

# Precompile additional assets.
# application.js, application.css, and all non-JS/CSS in the app/assets
# folder are already added.
# Rails.application.config.assets.precompile += %w( admin.js admin.css )

# The styleguide gem depends on bootstrap-sass and material_design_lite-sass,
# which both pull in autoprefixer-rails. It registers a sprockets postprocessor
# that runs postcss through execjs, so leaving it installed means the asset
# build needs a JavaScript runtime again.
#
# Nothing prefixed this app's CSS before: the styleguide came from npm, and
# postcss only ever ran inside webpack, which never compiled a stylesheet. So
# uninstalling the postprocessor keeps the compiled output as it was, and keeps
# the build Ruby-only.
Rails.application.config.assets.configure do |env|
  AutoprefixerRails::Sprockets.uninstall(env)
end
