FROM ruby:2.7-alpine3.13

ENV APP_ROOT=/usr/local/app \
    RAILS_LOG_TO_STDOUT=true
WORKDIR ${APP_ROOT}

RUN apk update && apk --no-cache add bash tzdata ca-certificates libstdc++ nodejs

ADD Gemfile Gemfile.lock ${APP_ROOT}/

RUN apk --update add --virtual build-dependencies build-base ruby-dev \
    libc-dev linux-headers libffi-dev zlib-dev \ 
    && bundle config --global silence_root_warning 1 \
    && bundle config set without 'development test' \ 
    && bundle install --path=vendor/bundle --jobs 4 --retry 3 \
    && apk del build-dependencies

RUN rm -rf /var/cache/apk/*

ADD . ${WORKDIR}  

RUN addgroup -g 3000 appuser \
    && adduser -D -u 3000 -G appuser appuser \
    && chown -R appuser:appuser /usr/local
USER appuser

ENV RAILS_ENV=production \
    RAILS_SERVE_STATIC_FILES=true \
    RAILS_LOG_TO_STDOUT=true

EXPOSE 3000
CMD ["bundle", "exec", "/usr/local/app/bin/rails", "server", "-b", "0.0.0.0"]
