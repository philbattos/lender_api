source 'https://rubygems.org'

#-------------------------------------------------
#    Rails Default Gems
#-------------------------------------------------
gem 'rails',        '4.2.4'
gem 'sass-rails',   '~> 5.0'
gem 'uglifier',     '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder',     '~> 2.0'
gem 'sdoc',         '~> 0.4.0', group: :doc

#-------------------------------------------------
#    Added Gems
#-------------------------------------------------
gem 'rack-cors',                :require => 'rack/cors' # for cross-origin requests
gem 'active_model_serializers'                          # for converting API data to json
gem 'responders'                                        # responder modules extracted from Rails
gem 'twilio-ruby'                                       # for text messaging
gem 'pg'                                                # use postgres db instead of sqlite
gem 'sidekiq'                                           # for background workers
gem 'aasm'                                              # state machine
gem 'possessive'                                        # for displaying possessive names
gem 'devise'                                            # for authentication

group :production do
  gem 'rails_12factor'                                  # for Heroku deployment
end

group :development, :test do
  gem 'byebug'        # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'rspec-rails'
  gem 'dotenv-rails'  # for storing environment variables
  gem 'pry-rails'     # for inspecting and debugging
end

group :development do
  gem 'web-console', '~> 2.0' # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'spring'                # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
end

ruby '2.2.2' # for Heroku