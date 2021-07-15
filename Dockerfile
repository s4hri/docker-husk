ARG DOCKER_SRC
ARG NVIDIA_ENV=0

FROM ${DOCKER_SRC} AS base
LABEL maintainer="Davide De Tommaso <davide.detommaso@iit.it>, Adam Lukomski <adam.lukomski@iit.it>"

ENV DEBIAN_FRONTEND noninteractive

ARG LOCAL_USER_ID

ENV LOCAL_USER_ID=${LOCAL_USER_ID}
ENV NVIDIA_ENV=${NVIDIA_ENV}

FROM base AS base-0
USER root

FROM base AS base-1
USER root
RUN apt-get update && apt-get install -y --no-install-recommends \
    libxau6 libxdmcp6 libxcb1 libxext6 libx11-6
ENV NVIDIA_VISIBLE_DEVICES=all
ENV NVIDIA_DRIVER_CAPABILITIES=graphics,utility
RUN /bin/sh -c echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf && \
    echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf
ENV LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:/usr/lib/i386-linux-gnu:/usr/local/nvidia/lib:/usr/local/nvidia/lib64
RUN apt-get update && apt-get install -y --no-install-recommends  \
    libglvnd0 libgl1 libglx0 libegl1 libgles2
RUN apt-get update && apt-get install -y --no-install-recommends  \
    pkg-config libglvnd-dev libgl1-mesa-dev libegl1-mesa-dev libgles2-mesa-dev


FROM base-${NVIDIA_ENV} AS final
RUN usermod -u ${LOCAL_USER_ID} docky
USER docky
