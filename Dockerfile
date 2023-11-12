FROM ruby:3.2

ENV LANG=C.UTF-8 \
  TZ=Asia/Tokyo

RUN mkdir /my-onsen-book-rails
WORKDIR /my-onsen-book-rails
RUN apt-get update -qq && apt-get install -y nodejs default-mysql-client
COPY Gemfile /my-onsen-book-rails/Gemfile
COPY Gemfile.lock /my-onsen-book-rails/Gemfile.lock
RUN bundle install
ADD . /my-onsen-book-rails

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]
