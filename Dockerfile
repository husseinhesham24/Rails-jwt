FROM ruby:3.0.0-alpine3.12

RUN apk --no-cache --update --available upgrade

RUN apk add --no-cache --update \
  && apk add build-base \
  git \
  postgresql-dev \
  postgresql-client \
  tzdata \
  curl bash

WORKDIR /app

COPY Gemfile* ./

RUN bundle install

COPY . .

EXPOSE 3000

CMD ["bash"]