require 'cucumber'
require 'rubygems'
require 'selenium-webdriver'
require 'yaml'
require_relative('../support/debug_hooks.rb')

# initiañizing the driver and log file
$driver = Selenium::WebDriver.for  :chrome
$LOG = Logger.new('../data/out/log_file.log', 'monthly')
logger = $LOG


# Triggering the URL before each scenario
Before do |scenario|
  logger.info("In before Hooks triggering the browser")
  puts $driver
  driver = $driver
  search_URL = YAML::load(File.open("../../Instructions/data/parameters.yml"))
  driver.get search_URL[:URL]
  logger.info("Opened the browser with given URL")
end

#Checking if scenario is failed
After do |scenario|
  logger.info("In after Hooks checking if scenario is passed ot failed")
  if scenario.failed?
    logger.error("The scenario named "+scenario.to_s+"is failed")
  else
    logger.info("The scenario named "+scenario.to_s+" is passed!")
  end
  
end