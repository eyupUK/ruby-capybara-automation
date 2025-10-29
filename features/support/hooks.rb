Before do
  # Add any per-scenario setup here
end

After do
  # Clean up session after each scenario to prevent interference
  if respond_to?(:page) && page
    # Clear any items from cart by navigating to products page
    begin
      visit "#{ENV['BASE_URL'] || 'https://www.saucedemo.com'}/inventory.html"
    rescue
      # Ignore errors during cleanup
    end
  end
end
