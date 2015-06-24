require 'rails_helper'
require 'capybara/rspec'
require 'capybara/poltergeist'
require 'rack_session_access/capybara'
include ActionView::RecordIdentifier

Capybara.javascript_driver = :poltergeist

RSpec.configure do |config|
  config.include SessionTestHelpers

  config.before(:each) do
    Capybara.reset!
  end
end
