source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'

# Database
gem 'mysql2'

# Setting utility - config/Application.yml
gem 'settingslogic'

# AWS integration
gem 'aws-sdk'

group :production do
  gem 'unicorn'
  gem 'exception_notification'
end

group :staging do
  gem 'unicorn'
  gem 'exception_notification'
end

# Use Capistrano for deployment
group :development do
  # Deploy
  gem 'capistrano'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano-rbenv'

  # Speed up loading
  gem 'spring'
end