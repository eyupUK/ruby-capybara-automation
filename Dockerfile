FROM ruby:3.2

# Install Chrome & dependencies
RUN apt-get update && apt-get install -y --no-install-recommends \
    wget gnupg ca-certificates apt-transport-https unzip \    chromium chromium-driver \  && rm -rf /var/lib/apt/lists/*

ENV CHROME_BIN=/usr/bin/chromium
ENV CHROMEDRIVER_BIN=/usr/bin/chromedriver

WORKDIR /app
COPY Gemfile* /app/
RUN gem update --system && gem install bundler && bundle install
COPY . /app

ENV BASE_URL=https://www.saucedemo.com
ENV APP_ENV=ci

CMD ["bash", "-lc", "bundle exec cucumber -p ci"]
