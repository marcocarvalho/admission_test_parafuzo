FROM ruby:2.4.2-alpine

# When updating it is required to force
# the version number to avoid docker cache
RUN apk --no-cache add build-base git
RUN gem install bundler -v '1.15.3'
RUN gem update --system
RUN bundle config git.allow_insecure true

ENV APP /app/

RUN mkdir -p $APP
WORKDIR $APP

ADD . $APP
RUN bundle install --jobs 3 --retry 20

EXPOSE 3000
