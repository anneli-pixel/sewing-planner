source 'https://rubygems.org'

ruby file: '.ruby-version'

gem 'rails', '~> 8.1.4'
# Use postgresql as the database for Active Record
gem 'pg', '~> 1.5'
# Use Puma as the app server
gem 'puma', '>= 6.0'
# Asset pipeline for stylesheets and images
gem 'sprockets-rails'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Bundle JavaScript with esbuild (replaces Webpacker). Read more: https://github.com/rails/jsbundling-rails
gem 'jsbundling-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'
# Use Redis adapter to run Action Cable in production
gem 'redis', '>= 4.0'

gem 'pundit'

# Use PG Search for search
gem 'pg_search'
# Use Active Model has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', require: false

gem 'devise'

gem 'autoprefixer-rails'
gem 'font-awesome-sass', '~> 5.15'
gem 'simple_form'
gem 'cloudinary', '~> 2.0'

group :development, :test do
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'dotenv-rails'
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'factory_bot_rails'
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console'
  gem 'listen'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara'
  gem 'selenium-webdriver'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[windows jruby]
