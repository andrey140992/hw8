FROM ruby:3.0.2

RUN apt-get update 

ADD . /Rails-Docker
WORKDIR /Rails-Docker
COPY Gemfile /hw5/Gemfile
COPY Gemfile.lock /hw5/Gemfile.lock
RUN bundle install

EXPOSE 3000






