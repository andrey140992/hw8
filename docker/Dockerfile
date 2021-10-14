FROM ruby:3.0.2

RUN apt-get update 

WORKDIR $SRC_PATH
COPY Gemfile /hw5/Gemfile
COPY Gemfile.lock /hw5/Gemfile.lock
RUN bundle install

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]