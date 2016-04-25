FROM ruby:2.3.0
MAINTAINER kchoubacha@sellbrite.com

RUN apt-get update

# basics
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev \
                                             nodejs wget imageMagick \
                                             openssl unzip zip
RUN apt-get install -y postgresql-client

# bundle gems
WORKDIR /tmp
COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install --retry=5 --jobs=2

RUN mkdir /myapp
WORKDIR /myapp
COPY . /myapp
