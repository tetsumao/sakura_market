source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.4'

gem 'rails', '~> 6.0.3'
gem 'pg', '>= 0.18', '< 2.0'
gem 'puma', '~> 4.3'
gem 'sass-rails', '>= 6'
gem 'webpacker', '~> 4.0'
gem 'turbolinks', '~> 5'
gem 'bcrypt', '~> 3.1.7'

gem 'bootsnap', '>= 1.4.2', require: false

gem 'haml-rails'
gem 'devise'
gem 'kaminari'
gem 'simple_form'
gem 'toastr-rails'
gem 'carrierwave', '~> 1.3.1'
gem 'mini_magick'
gem 'date_validator'
gem 'valid_email2'
gem 'stripe'

group :development, :test do
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'webdrivers'
  gem 'rspec-rails'
  gem 'factory_bot_rails'
end

group :production do
  gem 'rails_12factor'
  gem 'cloudinary', '1.11.1'
end

#gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
