FROM ruby:3.0.3

WORKDIR /app

COPY Gemfile ./

COPY Gemfile.lock ./

RUN bundle install

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
