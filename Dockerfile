FROM elixir:1.13-alpine AS build

# install build dependencies
RUN apk add --no-cache build-base npm git python3

# prepare build dir
WORKDIR /app

# install hex + rebar
RUN mix local.hex --force && \
  mix local.rebar --force

ARG MIX_ENV

# install mix dependencies
COPY mix.exs mix.lock ./
COPY config config
RUN mix do deps.get, deps.compile

COPY priv/repo priv/repo

# compile and build release
COPY lib lib
RUN mix do compile, release

# prepare release image
FROM alpine:latest AS app
# TODO: What is a required dependecy for our app and what is randomly added or is a dependecy of a dependency?
# OpenSSL, ncurses-libs, libstdc++ - ???
# Chromium - ChromicPDF
# Git - Git client inside app
# ImageMagick - Image transformation
RUN apk add --no-cache openssl ncurses-libs git chromium libstdc++ imagemagick

ARG MIX_ENV
ENV HOME=/app
ENV XDG_RUNTIME_DIR=/tmp/runtime-nobody

WORKDIR /app

RUN chown nobody:nobody /app

USER nobody:nobody

COPY --from=build --chown=nobody:nobody /app/_build/${MIX_ENV}/rel/prod ./

CMD ["bin/prod", "start"]
