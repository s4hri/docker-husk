ARG DOCKER_SRC
ARG NVIDIA_ENV=0

FROM ${DOCKER_SRC} AS base
LABEL maintainer="Davide De Tommaso <davide.detommaso@iit.it>, Adam Lukomski <adam.lukomski@iit.it>"

ENV DEBIAN_FRONTEND noninteractive

ARG LOCAL_USER_ID

ENV LOCAL_USER_ID=${LOCAL_USER_ID}
ENV NVIDIA_ENV=${NVIDIA_ENV}

USER root

COPY setup.sh /setup.sh

RUN ./setup.sh

RUN rm /setup.sh

RUN usermod -u ${LOCAL_USER_ID} docky
USER docky
