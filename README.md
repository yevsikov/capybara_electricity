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
      future=2 
      street = 'Парковая' #'Елисаветинская'
      date = Date.today+future 
      query = "?date=#{date}"
      screen_folder = 'test/integration/screens/'
      screen_file = screen_folder + Time.now.strftime("%s")+'.png'
      date_on_page=Time.now+future*60*60*24
      
      visit "/#{query}"
      assert page.has_content? date_on_page.strftime("%d.%m.%Y")
      
      if page.has_no_content? street   
        puts "Without blackouts"  
      else
        puts "WARNING: blackout!"  
        page.save_screenshot screen_file
      end  		
      
    end  
    
  end
