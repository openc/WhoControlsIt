source 'https://rubygems.org'
ruby '2.1.2'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.1.0'
# Use sqlite3 as the database for Active Record
gem 'mysql2'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.3'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',        group: :doc

# Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
gem 'spring',      group: :development
gem 'kaminari'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

group :development, :test do
  gem 'spring-commands-rspec'
  gem "rspec-rails", ">= 2.0.1"
  gem 'guard-rspec'
  gem 'rb-fsevent' if `uname` =~ /Darwin/
end

gem "capybara", group: [:development, :test]
gem "jquery-rails"
gem "jquery-ui-rails"

# Bootstrap
gem "therubyracer"
gem "less-rails" #Sprockets (what Rails 3.1 uses for its asset pipeline) supports LESS
gem "twitter-bootstrap-rails"
gem 'simple_form'

gem 'sigma-rails'
gem 'fog'
gem 'carrierwave'
