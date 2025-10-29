# Ruby+Cucumber+Capybara Test Automation Framework

A production-ready **BDD test automation framework** for web applications using Ruby, Cucumber, and Capybara. Features comprehensive SauceDemo e-commerce testing with robust element handling and cross-browser compatibility.

## ✅ Current Test Coverage

### SauceDemo E-commerce Testing

- **Login Authentication** - Valid/invalid credentials, locked user scenarios
- **Shopping Cart Operations** - Add/remove products, cart badge validation  
- **Complete Checkout Flow** - Form input, payment processing, order confirmation
- **Modal Dialog Handling** - Password change warnings and dismissal
- **Cross-browser Support** - Chrome headless and UI modes

## 🛠 Tech Stack

- **Ruby 3.2.2** (via rbenv)
- **Cucumber 9.2.1** - BDD test framework
- **Capybara 3.40.0** - Web interaction library
- **Selenium WebDriver 4.38.0** - Browser automation
- **SitePrism 4.0.3** - Page Object Model pattern
- **RSpec** - Unit testing framework
- **SimpleCov** - Test coverage reporting
- **Docker** - Containerized test execution

## 🚀 Quick Start

### Prerequisites

- Ruby 3.2.2 (install via rbenv)
- Bundler gem
- Chrome browser (for UI tests)

### Installation

```bash
# 1) Install dependencies
bundle install

# 2) Run all SauceDemo tests (headless)
make test-saucedemo

# 3) Run tests with visible browser (UI mode)
make test-ui

# 4) Run specific test suites
bundle exec cucumber features/saucedemo_login.feature    # Login tests
bundle exec cucumber features/saucedemo_cart.feature     # Cart tests  
bundle exec cucumber features/saucedemo_checkout.feature # Checkout tests

# 5) Run with specific tags
bundle exec cucumber --tags @smoke   # Smoke tests only
bundle exec cucumber --tags @regression   # Regression tests
```

### Available Make Commands

```bash
make test-saucedemo     # Run all SauceDemo tests (headless)
make test-ui           # Run all tests with visible browser
make test-ui-smoke     # Run smoke tests in UI mode
```

## 🐳 Docker Usage

```bash
# Build and run tests in container
docker compose build
docker compose run --rm test

# Run specific tests in Docker
docker compose run --rm test bundle exec cucumber features/saucedemo_login.feature
docker compose run --rm test bundle exec rspec
```

## ⚙️ Configuration

### Environment Files

- `config/environments/default.yml` - Base configuration
- `config/environments/dev.yml` - Development environment
- `config/environments/ci.yml` - CI/CD environment  
- `.env` - Local overrides (BASE_URL, credentials, etc.)

### Browser Drivers

The framework supports multiple browser configurations:

- `selenium_chrome_headless` - Default headless mode
- `selenium_chrome_ui` - Visible browser for debugging
- `selenium_chrome_debug` - UI mode with extended timeouts

Set `APP_ENV=ui` to run tests with visible browser.

## 📁 Project Structure

```text
features/
  ├── pages/                    # Page Object Model classes
  │   ├── login_page.rb
  │   ├── products_page.rb
  │   ├── cart_page.rb
  │   └── checkout_page.rb
  ├── step_definitions/         # Cucumber step implementations
  │   └── saucedemo_steps.rb
  ├── support/                  # Test configuration & hooks
  │   ├── env.rb               # Environment setup
  │   ├── capybara.rb          # Browser configuration
  │   └── hooks.rb             # Before/After scenario hooks
  ├── saucedemo_login.feature   # Login test scenarios
  ├── saucedemo_cart.feature    # Shopping cart scenarios
  └── saucedemo_checkout.feature # Checkout flow scenarios
spec/                           # Unit tests
lib/                           # Utility classes
config/environments/           # Environment configurations
Makefile                       # Build commands
```

## 🔧 Key Features & Fixes

### Robust Element Handling

- **Stale Element Recovery** - Automatic retry logic for dynamic DOM changes
- **Modal Dialog Support** - Handles SauceDemo password change modals
- **JavaScript Click Fallback** - Dual-click approach for compatibility
- **Form Input Enhancement** - JavaScript-based input for reliable data entry

### Test Reliability Improvements

- **Element Wait Strategies** - Extended timeouts for slow-loading elements  
- **Session Management** - Clean state between test scenarios
- **Product Availability Logic** - Dynamic product selection for cart operations
- **Cross-browser Compatibility** - Works in both headless and UI modes

## 🏃‍♂️ Test Execution Examples

```bash
# Run all tests with coverage
make test-saucedemo

# Debug specific test with visible browser
APP_ENV=ui bundle exec cucumber features/saucedemo_checkout.feature

# Run tests against custom URL
BASE_URL=https://staging.saucedemo.com make test-saucedemo

# Run with specific cucumber profile
bundle exec cucumber -p ci --tags @regression
```

## 📊 Test Reports

- **Coverage Reports** - Generated in `coverage/` directory
- **Screenshots** - Captured in `reports/screenshots/` on failures
- **Cucumber HTML Reports** - Available after test execution

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Add tests for new functionality
4. Ensure all tests pass: `make test-saucedemo`
5. Submit a pull request
