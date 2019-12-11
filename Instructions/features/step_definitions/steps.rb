require 'cucumber'
require 'rubygems'
require 'selenium-webdriver'
require 'yaml'
require_relative('../support/debug_hooks.rb')
require 'logger'

driver = $driver
$LOG = Logger.new('../data/out/log_file.log', 'monthly')
logger = $LOG

When(/^I LogIn in Upwork$/) do
  logger.info("Entered into upwork world")
end

Then(/^I search with keyword$/) do
  logger.info("Opened browser and started with the keywords search")
  search_name = YAML::load(File.open("../../Instructions/data/parameters.yml"))
  logger.info("The search keyword is : "+ search_name[:searchKeyword].to_s)
  searchKeyword=driver.find_element :xpath => "//div[@class='navbar-collapse d-none d-lg-flex sticky-sublocation']//input[@placeholder='Find Freelancers & Agencies']"
  searchKeyword.send_keys search_name[:searchKeyword]
end

Then(/^I click on search button$/) do
  searchSubmitButton = driver.find_element :xpath => "//div[@class='navbar-collapse d-none d-lg-flex sticky-sublocation']//button[@type='submit']"
  searchSubmitButton.click
  logger.info("Clicked the search button")
end

Then(/^I search through all profile and compare a random profile in and out$/) do
  int row_count_on_page = driver.find_elements(:xpath => "//section[@id='oContractorResults']/div/div/section").length
  logger.info("The total number of search results are "+row_count_on_page.to_s)
  freeLancer_details = Hash.new
  int searchResultsCount = 1
  results_array = []
  # The while loop runs until all the search results are loaded
  while searchResultsCount <= row_count_on_page
    # Adding multiple values to a single key (Key is the profile count and the values are name, title and location)
    freeLancer_details[searchResultsCount] = Array.new
    freeLancer_details[searchResultsCount] <<
    freeLancer_details[(driver.find_element :xpath => "//section[@id='oContractorResults']/div/div/section["+searchResultsCount.to_s+"]//a[@class='freelancer-tile-name']").text]
    freeLancer_details[searchResultsCount] <<
    (driver.find_element :xpath => "//section[@id='oContractorResults']/div/div/section["+searchResultsCount.to_s+"]//div[@data-title]").text
    freeLancer_details[searchResultsCount] <<
    (driver.find_element :xpath => "//section[@id='oContractorResults']/div/div/section["+searchResultsCount.to_s+"]//strong[@title]").text
    logger.info("The name of the Freelancer #{searchResultsCount} is "+freeLancer_details[searchResultsCount][0].to_s)
    logger.info("The title of the Freelancer #{searchResultsCount} is "+freeLancer_details[searchResultsCount][1].to_s)
    logger.info("The location of the Freelancer #{searchResultsCount} is "+freeLancer_details[searchResultsCount][2].to_s)

    #Pushing all the hashes into an array
    results_array.push(freeLancer_details[searchResultsCount])
    searchResultsCount  +=1
  end
  int randomNum = rand(row_count_on_page+1)
  randomProfile = driver.find_element :xpath => "//section[@id='oContractorResults']/div/div/section["+randomNum.to_s+"]//a[@class='freelancer-tile-name']"
  randomProfile.click

  selectedProfileName = driver.find_element :xpath => "//div[@id='oProfilePage']//span[@itemprop='name']".text
  selectedProfileTitle = driver.find_element :xpath => "//div[@id='oProfilePage']//div[@id='optimizely-header-container-default']//div[@class='up-active-container']/h3/span/span[1]".text
  selectedProfileLocation = driver.find_element :xpath => "//div[@id='oProfilePage']//div[@id='optimizely-header-container-default']//div[@class='fe-profile-header-local-time']//span[@ng-class='labelClass']".text

  #Success flag is to vlidate if all the three details of the freelnacer are matched
  int successFlag = 0

  # Validating if the name is matched
  if results_array[freeLancer_details[randomNum]][0].include? selectedProfileName
    logger.info("The selected profile name is matched with the profile name that displayed in the search results")
    successFlag +=1
  end

  # Validating if the profile title is matched
  if results_array[freeLancer_details[randomNum]][1].include? selectedProfileTitle
    logger.info("The selected profile title is matched with the profile title that displayed in the search results")
    successFlag +=1
  end

  # Validating if the profile location is matched
  if results_array[freeLancer_details[randomNum]][2].include? selectedProfileLocation
    logger.info("The selected freelancer location is matched with the location that displayed in the search results")
    successFlag +=1
  end

  # If all the three are matched then test is success
  if successFlag ==3
    logger.info("The profile details displayed in the search results as well as content in the detailed information page are identical")

  end
end

