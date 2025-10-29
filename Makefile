setup:
	gem install bundler && bundle install

test-saucedemo:
	BASE_URL=https://www.saucedemo.com bundle exec cucumber features/saucedemo_*.feature

test-smoke:
	BASE_URL=https://www.saucedemo.com bundle exec cucumber -p default --tags @smoke

test-ui:
	APP_ENV=ui bundle exec cucumber features/saucedemo_login.feature

test-ui-all:
	APP_ENV=ui bundle exec cucumber features/saucedemo_*.feature

test-ui-smoke:
	APP_ENV=ui bundle exec cucumber -p default --tags @smoke

test-ui-debug:
	APP_ENV=ui bundle exec cucumber features/saucedemo_login.feature --format pretty --verbose

test-debug:
	APP_ENV=debug bundle exec cucumber features/saucedemo_login.feature --format pretty

test-api:
	bundle exec rspec

docker-build:
	docker compose build

docker-test:
	docker compose run --rm test
