# This file is used by CI pipeline when testing this action
FROM alpine:latest@sha256:1e42bbe2508154c9126d48c2b8a75420c3544343bf86fd041fb7527e017a4b4a

RUN apk update \
  && apk -a info curl \
  && apk add curl

# these two are passed as build arguments
ARG BUILD_DATE
ARG GITHUB_SHA

ENV GITHUB_SHA=$GITHUB_SHA

RUN env | sort