FROM ruby:2.4-alpine3.6

RUN apk add --no-cache bash nodejs tzdata less
RUN apk add --no-cache alpine-sdk \
      --virtual .build_deps libxml2-dev libxslt-dev zlib zlib-dev readline-dev

ENV BUNDLE_PATH /bundle
ENV BUNDLE_DISABLE_SHARED_GEMS 1

RUN echo -e 'install: --no-document\nupdate: --no-document' >> ~/.gemrc
RUN gem install bundler -v 1.15.4
RUN gem install rails -v '~>5.1.0'

WORKDIR /var/myapp

CMD sh
