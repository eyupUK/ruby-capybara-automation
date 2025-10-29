require 'dotenv/load'
require 'capybara/cucumber'
require 'site_prism'
require 'selenium-webdriver'
require 'yaml'
require 'simplecov'

SimpleCov.start do
  add_filter '/features/'
end

ENV['RACK_ENV'] ||= 'dev'
ENV['APP_ENV']  ||= ENV['RACK_ENV']

CONFIG = YAML.load_file(File.join(__dir__, '../../config/environments/default.yml'))
env_file = File.join(__dir__, "../../config/environments/#{ENV['APP_ENV']}.yml")
if File.exist?(env_file)
  CONFIG.merge!(YAML.load_file(env_file) || {})
end

Capybara.configure do |config|
  config.default_max_wait_time = CONFIG['implicit_wait'] || 2
  config.app_host = ENV['BASE_URL'] || CONFIG['base_url']
  # Use UI driver if CAPYBARA_DRIVER is set or if browser config specifies UI
  config.default_driver = ENV['CAPYBARA_DRIVER']&.to_sym || CONFIG['browser']&.to_sym || :selenium_chrome_headless
end

# Register drivers
Capybara.register_driver :selenium_chrome_headless do |app|
  opts = Selenium::WebDriver::Chrome::Options.new
  opts.add_argument('--headless=new')
  opts.add_argument('--disable-gpu')
  opts.add_argument('--no-sandbox')
  opts.add_argument('--disable-dev-shm-usage')
  opts.add_argument('--window-size=1920,1080')
  opts.add_argument('--disable-infobars')              # hides “Chrome is being controlled by automated test software”
opts.add_argument('--ignore-certificate-errors')     # ignore SSL cert warnings
opts.add_argument('--disable-extensions')            # ensure no Chrome extensions run
opts.add_argument('--disable-notifications')         # suppress web push notifications


  # 🧩 Disable Chrome password manager & “Change password” infobar
  opts.add_argument('--disable-password-generation')
  opts.add_argument('--disable-save-password-bubble')
  opts.add_argument('--disable-features=PasswordManagerOnboarding,PasswordChange,PasswordLeakDetection')

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: opts)
end


# Register UI-visible driver (non-headless)
Capybara.register_driver :selenium_chrome_ui do |app|
  opts = Selenium::WebDriver::Chrome::Options.new
  opts.add_argument('--disable-gpu')
  opts.add_argument('--no-sandbox')
  opts.add_argument('--disable-dev-shm-usage')
  opts.add_argument('--window-size=1920,1080')
  opts.add_argument('--disable-infobars')              # hides “Chrome is being controlled by automated test software”
opts.add_argument('--ignore-certificate-errors')     # ignore SSL cert warnings
opts.add_argument('--disable-extensions')            # ensure no Chrome extensions run
opts.add_argument('--disable-notifications')         # suppress web push notifications

  # No --headless argument = browser will be visible
    # 🧩 Disable Chrome password manager & “Change password” infobar
  opts.add_argument('--disable-password-generation')
  opts.add_argument('--disable-save-password-bubble')
  opts.add_argument('--disable-features=PasswordManagerOnboarding,PasswordChange,PasswordLeakDetection')

  Capybara::Selenium::Driver.new(app, browser: :chrome, options: opts)
end

# Register debug driver (slower for demo/debugging)
Capybara.register_driver :selenium_chrome_debug do |app|
  opts = Selenium::WebDriver::Chrome::Options.new
  opts.add_argument('--disable-gpu')
  opts.add_argument('--no-sandbox') 
  opts.add_argument('--disable-dev-shm-usage')
  opts.add_argument('--window-size=1920,1080')
  opts.add_argument('--start-maximized')
  opts.add_argument('--disable-infobars')              # hides “Chrome is being controlled by automated test software”
  opts.add_argument('--ignore-certificate-errors')     # ignore SSL cert warnings
  opts.add_argument('--disable-extensions')            # ensure no Chrome extensions run
  opts.add_argument('--disable-notifications')         # suppress web push notifications

  # 🧩 Disable Chrome password manager & “Change password” infobar
  opts.add_argument('--disable-password-generation')
  opts.add_argument('--disable-save-password-bubble')
  opts.add_argument('--disable-features=PasswordManagerOnboarding,PasswordChange,PasswordLeakDetection')

  driver = Capybara::Selenium::Driver.new(app, browser: :chrome, options: opts)
  # Add pause after each action for demonstration
  driver.browser.manage.timeouts.implicit_wait = 1
  driver
end

# Page object container
class Pages
  def login
    @login ||= LoginPage.new
  end
  
  def products
    @products ||= ProductsPage.new
  end
  
  def cart
    @cart ||= CartPage.new
  end
  
  def checkout
    @checkout ||= CheckoutPage.new
  end
end

Before do
  @pages = Pages.new
end

require_relative '../pages/login_page'
require_relative '../pages/products_page'
require_relative '../pages/cart_page'
require_relative '../pages/checkout_page'
