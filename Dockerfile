# This file is used by CI pipeline when testing this action
FROM alpine:latest@sha256:b89d9c93e9ed3597455c90a0b88a8bbb5cb7188438f70953fede212a0c4394e0

RUN apk update \
  && apk -a info curl \
  && apk add curl

# these two are passed as build arguments
ARG BUILD_DATE
ARG GITHUB_SHA

ENV GITHUB_SHA=$GITHUB_SHA

RUN env | sort