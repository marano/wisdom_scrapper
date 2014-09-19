require 'rubygems'
require 'bundler'
Bundler.require
require 'capybara/dsl'

Capybara.register_driver :selenium_with_chrome do |app|
  Capybara::Selenium::Driver.new(app, browser: :chrome)
end

session = Capybara::Session.new(:selenium_with_chrome)

while true
  session.visit('http://www.wisdomofchopra.com/iframe.php')
  wisdom = ''
  while wisdom.count('"') < 2
    wisdom = session.find('#quote').text
  end
  File.open('wisdom.txt', 'a') { |f| f.write(wisdom.gsub('"', '').gsub('_', '').strip + "\n") }
end

