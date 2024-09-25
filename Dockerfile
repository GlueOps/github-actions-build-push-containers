# This file is used by CI pipeline when testing this action
FROM alpine:latest@sha256:beefdbd8a1da6d2915566fde36db9db0b524eb737fc57cd1367effd16dc0d06d

RUN apk update \
  && apk -a info curl \
  && apk add curl

# these two are passed as build arguments
ARG BUILD_DATE
ARG GITHUB_SHA

ENV GITHUB_SHA=$GITHUB_SHA

RUN env | sort