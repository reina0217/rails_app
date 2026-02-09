# rails_app/Dockerfile
FROM ruby:3.4.2

RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

WORKDIR /rails_app01

COPY Gemfile Gemfile.lock ./
RUN gem install bundler && bundle install

COPY . .

RUN bundle exec rails webpacker:install || true