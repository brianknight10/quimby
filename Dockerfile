FROM alpine:3.10

RUN apk update && apk --update add ruby ruby-irb ruby-json ruby-rake \  
    ruby-bundler ruby-bigdecimal ruby-io-console libstdc++ tzdata nodejs

ADD Gemfile /app/  
ADD Gemfile.lock /app/

RUN apk --update add --virtual build-dependencies build-base ruby-dev \
    openssl-dev libc-dev linux-headers libffi-dev ca-certificates zlib-dev && \
    cd /app ; bundle install --without development test

RUN rm -rf /var/cache/apk/*

ADD . /app  
RUN chown -R nobody:nogroup /app  
USER nobody

ENV RAILS_ENV=production \
    RAILS_SERVE_STATIC_FILES=true \
    RAILS_LOG_TO_STDOUT=true

WORKDIR /app
RUN bundle exec rake assets:precompile

EXPOSE 3000
CMD ["rails", "server", "-b", "0.0.0.0"]
