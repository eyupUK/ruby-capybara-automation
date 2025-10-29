class ProductsPage < SitePrism::Page
  set_url '/inventory.html'

  element :cart_badge, '.shopping_cart_badge'
  element :cart_container, '.shopping_cart_container'
  element :cart_link, '.shopping_cart_link'


  def add_product(name)
    # Convert product name to ID format - keep "Sauce Labs" prefix
    id_suffix = name.downcase
                   .gsub(' ', '-')
                   .gsub(/[()]/, '')
    button_id = "add-to-cart-#{id_suffix}"
    
    # Wait for page to fully load
    sleep 2
    
    # Retry logic for element not found and stale element references
    retries = 5
    begin
      # Wait longer for the button to appear
      button = find("##{button_id}", wait: 10)
      
      # Scroll to button and click using both methods for reliability
      page.execute_script('arguments[0].scrollIntoView(true);', button)
      sleep 0.5
      
      # Use both regular and JavaScript click for maximum compatibility
      button.click
      page.execute_script('arguments[0].click();', button)
      
    rescue Capybara::ElementNotFound, Selenium::WebDriver::Error::StaleElementReferenceError
      retries -= 1
      if retries > 0
        sleep 2
        retry
      else
        raise
      end
    end
  end

  def remove_product(name)
    # Convert product name to ID format - keep "Sauce Labs" prefix  
    id_suffix = name.downcase.gsub(' ', '-').gsub(/[()]/, '')
    button_id = "remove-#{id_suffix}"
    
    # Retry logic for stale element references
    retries = 3
    begin
      button = find("##{button_id}")
      
      # Scroll to button and click using both methods for reliability
      page.execute_script('arguments[0].scrollIntoView(true);', button)
      sleep 0.5
      
      # Use both regular and JavaScript click for maximum compatibility
      button.click
      page.execute_script('arguments[0].click();', button)
      
    rescue Selenium::WebDriver::Error::StaleElementReferenceError
      retries -= 1
      if retries > 0
        sleep 1
        retry
      else
        raise
      end
    end
  end

end
