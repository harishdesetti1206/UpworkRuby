
# Sample flow to validate the freelancer results in upwork site

# Test Environment
- Cucumber Framework
- Ruby Language
- Eclipse IDE
- Selenium Webdriver

# How to run the project
- open terminal (cmd) and run the following commands 
     -gem install selenium-webdriver -v 2.53.0
     - gem install cucumber
     - gem install rails
     - gem install logger
- Download chrome too to run this project
- clone the repository from terminal in any folder using git clone https://github.com/harishdesetti1206/UpworkRuby.git
- open the IDE(Eclipse)
- open the project using file tab--> open --> select project
- select the language - Ruby from preferences --> language and framework
- You can run the project as belo
   Go to the directory ../Instructions/features
   Using  terminal :
    - cucumber -r step_definitions ResultsValidating.feature
    
    OR
    
    - cucumber -r step_definitions *.feature to run all the features
    
    
    
# Logging : 
    - All the info, debug and error logs are captured in ../Instructions/features/log_fie.log
    
# Test data:
    -  Test data can be passed using the parameter.yml file in the ../Instructions/data/parameter.yml
    
