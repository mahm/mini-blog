source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.6'

gem 'rails'
gem 'bootsnap', '>= 1.4.2', require: false

gem 'pg'
gem 'puma'
gem 'sassc-rails'
gem 'webpacker'
gem 'devise'
gem 'hamlit-rails'
gem 'vue_custom_element_rails', github: 'SonicGarden/vue-custom-element-rails'
gem 'graphql'
gem 'graphql-batch'
gem 'rails_same_site_cookie'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  gem 'web-console'
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'graphiql-rails'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'webdrivers'
end
