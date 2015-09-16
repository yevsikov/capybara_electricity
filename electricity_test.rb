     #rake test:integration TEST=test/integration/electricity_test.rb
     require 'test_helper'
     require 'rubygems'
     require 'selenium-webdriver'
     require 'date'
         class ElectricityTest < ActionDispatch::IntegrationTest
         include Capybara::DSL
         setup do
             Capybara.current_driver = Capybara.javascript_driver
             Capybara.app_host = 'http://www.oblenergo.odessa.ua/index.php/ru/grafiki-otklyuchenij'
             page.driver.browser.manage.delete_all_cookies
             #page.driver.browser.manage.window.maximize
         end
         test 'should_get_to_the_oblenergo_site' do
             future = 1
             street = 'Елисаветинская'
             date_to_search = Time.now+future*60*60*24
             query = "?date=#{date_to_search.strftime('%Y-%m-%d')}"
             screen_folder = 'test/integration/screens/'
             screen_file = screen_folder + Time.now.strftime("%s")+'.png'
             visit "/#{query}"
             assert page.has_content? date_to_search.strftime("%d.%m.%Y")
             if page.has_no_content? street   
                 puts "Without blackouts"  
             else
                 puts "WARNING: blackout!"  
                 page.save_screenshot screen_file
             end  		
          end 
     end
