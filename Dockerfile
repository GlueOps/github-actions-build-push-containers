# This file is used by CI pipeline when testing this action
FROM alpine:latest@sha256:77726ef6b57ddf65bb551896826ec38bc3e53f75cdde31354fbffb4f25238ebd

RUN apk update \
  && apk -a info curl \
  && apk add curl

# these two are passed as build arguments
ARG BUILD_DATE
ARG GITHUB_SHA

ENV GITHUB_SHA=$GITHUB_SHA

RUN env | sort