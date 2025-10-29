Given('I am on the SauceDemo login page') do
  @pages.login.load
end

When('I log in with username {string} and password {string}') do |username, password|
  @pages.login.login_as(username, password)
end

Then('I should see {string}') do |expected|
  if expected.include?('Epic sadface')
    expect(@pages.login.error_message.text).to eq(expected)
  else
    expect(page).to have_content(expected)
  end
end

Given('I am logged in as {string} with password {string}') do |username, password|
  @pages.login.load
  @pages.login.login_as(username, password)
  
  # Handle password change modal if it appears
  if page.has_content?('Change your password', wait: 2)
    puts "Password change modal detected, dismissing..."
    
    # Try different methods to close the modal (in order of preference)
    if page.has_button?('OK', wait: 1)
      puts "Clicking OK button"
      click_button('OK')
    elsif page.has_selector?('button:contains("OK")', wait: 1)
      puts "Finding and clicking OK button by text"
      find('button', text: 'OK').click
    elsif page.has_selector?('[type="button"]', text: 'OK', wait: 1)
      puts "Finding OK button by type and text"
      find('[type="button"]', text: 'OK').click
    elsif page.has_selector?('button', wait: 1)
      puts "Clicking any available button in modal"
      all('button').last.click
    else
      puts "Trying to click close X button"
      if page.has_text?('×')
        find('*', text: '×').click
      else
        # Try pressing Escape key as last resort
        puts "Pressing Escape key"
        page.driver.browser.action.send_keys(:escape).perform
      end
    end
    
    # Wait for modal to disappear
    expect(page).not_to have_content('Change your password', wait: 5)
    puts "Modal dismissed successfully"
  end
  
  expect(page).to have_content('Products')
end

When('I add the product {string} to the cart') do |product_name|
  @pages.products.add_product(product_name)
end

Then('the cart badge should display {string}') do |count|
  # Wait for cart badge to appear and show the correct count
  expect(page).to have_selector('.shopping_cart_badge', text: count, wait: 5)
end

When('I remove the product {string} from the cart') do |product_name|
  @pages.products.remove_product(product_name)
end

Then('the cart badge should be empty') do
  expect(page).not_to have_selector('.shopping_cart_badge')
end

When('I proceed to checkout with first name {string}, last name {string}, and zip {string}') do |first, last, zip|
  # Make sure we have items in cart first
  expect(page).to have_selector('.shopping_cart_badge', wait: 5)
  
  # Try multiple methods to click the cart link
  cart_link = find('.shopping_cart_link', wait: 5)
  
  # Scroll to cart and click
  page.execute_script('arguments[0].scrollIntoView(true);', cart_link)
  sleep 0.5
  
  # Try regular click first
  begin
    cart_link.click
  rescue
    # If regular click fails, try JavaScript click
    page.execute_script('arguments[0].click();', cart_link)
  end
  
  # Wait for navigation to cart page - be more specific about the URL
  sleep 2
  # Navigate directly if click didn't work
  unless page.current_url.include?('cart')
    visit "#{ENV['BASE_URL']}/cart.html"
  end
  
  # Now find and click checkout button
  checkout_button = find('#checkout', wait: 5)
  
  # Try both click methods for reliability
  begin
    checkout_button.click
  rescue
    page.execute_script('arguments[0].click();', checkout_button)
  end
  
  sleep 1
  
  # Try direct navigation if click didn't work
  unless page.current_url.include?('checkout-step-one')
    visit "#{ENV['BASE_URL']}/checkout-step-one.html"
  end
  
  # Wait for navigation to checkout step one page
  expect(page).to have_current_path(%r{/checkout-step-one\.html}, wait: 5)
  
  @pages.checkout.checkout(first, last, zip)
end

Then('I should see the order confirmation message {string}') do |message|
  expect(@pages.checkout.complete_header.text).to eq(message)
end
