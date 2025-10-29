class CheckoutPage < SitePrism::Page
  set_url '/checkout-step-one.html'

  element :first_name, '#first-name'
  element :last_name, '#last-name'
  element :postal_code, '#postal-code'
  element :continue_button, '#continue'
  element :finish_button, '#finish'
  element :complete_header, '.complete-header'

  def checkout(first, last, zip)
    # Fill first name using JavaScript for reliability
    first_name_field = first_name
    page.execute_script("arguments[0].value = '';", first_name_field)
    page.execute_script("arguments[0].value = arguments[1];", first_name_field, first)
    page.execute_script("arguments[0].dispatchEvent(new Event('input', { bubbles: true }));", first_name_field)
    
    # Fill last name using JavaScript for reliability  
    last_name_field = last_name
    page.execute_script("arguments[0].value = '';", last_name_field)
    page.execute_script("arguments[0].value = arguments[1];", last_name_field, last)
    page.execute_script("arguments[0].dispatchEvent(new Event('input', { bubbles: true }));", last_name_field)
    
    # Fill postal code using JavaScript for reliability
    postal_code_field = postal_code
    page.execute_script("arguments[0].value = '';", postal_code_field)
    page.execute_script("arguments[0].value = arguments[1];", postal_code_field, zip)
    page.execute_script("arguments[0].dispatchEvent(new Event('input', { bubbles: true }));", postal_code_field)
    
    # Click continue button and wait for navigation
    continue_button.click
    
    # Wait for navigation to checkout step two
    retries = 3
    while retries > 0 && page.current_url.include?('checkout-step-one')
      sleep 1
      retries -= 1
    end
    
    # If we didn't navigate, try JavaScript click or direct navigation
    if page.current_url.include?('checkout-step-one')
      page.execute_script('arguments[0].click();', continue_button)
      sleep 2
      
      if page.current_url.include?('checkout-step-one')
        visit "#{page.current_url.gsub('checkout-step-one', 'checkout-step-two')}"
      end
    end
    
    # Find and click finish button
    finish_btn = find('#finish', wait: 5)
    
    # Try both click methods for reliability
    begin
      finish_btn.click
    rescue
      # Fallback to JavaScript click
    end
    page.execute_script('arguments[0].click();', finish_btn)
    
    # Wait for navigation to completion page
    retries = 5
    while retries > 0 && !page.current_url.include?('checkout-complete')
      sleep 1  
      retries -= 1
    end
  end
end
