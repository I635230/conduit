FROM ruby:3.2.2

WORKDIR /conduit

COPY Gemfile /conduit/Gemfile
COPY Gemfile.lock /conduit/Gemfile.lock

RUN bundle install

CMD ["rails", "server", "-b", "0.0.0.0"]