FROM ruby:2.6.1

RUN mkdir /users-ms
WORKDIR /users-ms

ADD Gemfile /users-ms/Gemfile
ADD Gemfile.lock /users-ms/Gemfile.lock

RUN gem install bundler

RUN bundle install
ADD . /users-ms

EXPOSE 3000