require 'bundler/inline'

gemfile do 
  gem 'capybara'
  gem 'selenium'
  gem 'selenium-webdriver'
end

require './woffu_automation'
if ENV['WOFFU_URL']
  WoffuSign.new(ENV['WOFFU_URL']).play
else
  puts "Please, set your Woffu URL on ENV"
  return 
end

