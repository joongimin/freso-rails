source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.0'

# Database
gem 'mysql2'

# Paging
gem 'kaminari'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

group :production do
  gem 'unicorn'
  gem 'exception_notification'
end

# Use Capistrano for deployment
group :development do
  gem 'capistrano', '2.15.5'
end

# AWS integration
gem 'aws-sdk'