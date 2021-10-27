FROM ruby:3.0.2

RUN curl https://deb.nodesource.com/setup_14.x | bash
RUN curl https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list

RUN apt-get update && apt-get install -y nodejs yarn

ADD . /hw5
WORKDIR /hw5
COPY Gemfile /hw5/Gemfile
COPY Gemfile.lock /hw5/Gemfile.lock
RUN bundle install









