# Ruby+Cucumber+Capybara Test Automation Framework (Docker-ready)

A production-grade starter for **BDD acceptance tests** and **API/UI automation** for Ruby on Rails or any web backend.

## Tech Stack
- Ruby 3.2, Cucumber, Capybara, Selenium WebDriver, SitePrism (Page Objects)
- RSpec for unit tests
- HTTParty for API tests, WebMock/VCR for isolation
- SimpleCov for coverage, RuboCop for lint
- Docker + docker-compose for hermetic runs
- GitHub Actions CI

## Quick Start (Local)
```bash
# 1) Install Ruby 3.2 and bundler
gem install bundler
bundle install

# 2) Run SauceDemo tests
bundle exec cucumber features/saucedemo_*.feature

# 3) Run smoke tests
bundle exec cucumber -p default --tags @smoke

# 4) Run API tests
bundle exec rspec
```

## Run in Docker
```bash
docker compose build
docker compose run --rm test
# OR run specific tests:
docker compose run --rm test bundle exec cucumber features/saucedemo_login.feature
docker compose run --rm test bundle exec rspec
```

## Configuration

- `config/environments/*.yml` environment-specific config (merged over `default.yml`)
- `.env` for sensitive overrides (`BASE_URL`, credentials, etc.)

## Project Structure

```text
features/
  support/
  step_definitions/
  pages/
spec/
lib/
config/environments/
.github/workflows/ci.yml
Dockerfile
docker-compose.yml
```

## CI

GitHub Actions workflow runs Cucumber and RSpec in Docker, and uploads reports as artifacts.
# ruby-capybara-automation
