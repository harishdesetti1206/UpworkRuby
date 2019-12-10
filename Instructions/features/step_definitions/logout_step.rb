require 'cucumber'
require 'rubygems'
require 'selenium-webdriver'
require_relative('../support/debug_hooks.rb')


$LOG = Logger.new('../data/out/log_file.log', 'monthly')
logger = $LOG

# Added this step to extend the functionlity of needed
Then(/^I Logout of Upwork$/) do
  logger.info("I Logout from the  upwork")
end