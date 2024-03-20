# This file is used by CI pipeline when testing this action
FROM alpine:latest@sha256:c5b1261d6d3e43071626931fc004f70149baeba2c8ec672bd4f27761f8e1ad6b

RUN apk update \
  && apk -a info curl \
  && apk add curl

# these two are passed as build arguments
ARG BUILD_DATE
ARG GITHUB_SHA

ENV GITHUB_SHA=$GITHUB_SHA

RUN env | sort