require 'rails_helper'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'rack_session_access/capybara'

Capybara.javascript_driver = :poltergeist

RSpec.configure do |config|
  config.include SessionTestHelpers

  config.before(:suite) do
    begin
      DatabaseCleaner.start
      FactoryGirl.lint
    ensure
      DatabaseCleaner.clean
    end
  end

  config.before(:each) do
    Capybara.reset!
  end
end
