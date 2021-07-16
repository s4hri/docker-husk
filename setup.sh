if [ "${NVIDIA_ENV}" = 1 ]; then
  apt-get update && apt-get install -y --no-install-recommends \
      libxau6 libxdmcp6 libxcb1 libxext6 libx11-6
  export NVIDIA_VISIBLE_DEVICES=all
  export NVIDIA_DRIVER_CAPABILITIES=graphics,utility
  /bin/sh -c echo "/usr/local/nvidia/lib" >> /etc/ld.so.conf.d/nvidia.conf && \
  echo "/usr/local/nvidia/lib64" >> /etc/ld.so.conf.d/nvidia.conf
  export LD_LIBRARY_PATH=/usr/lib/x86_64-linux-gnu:/usr/lib/i386-linux-gnu:/usr/local/nvidia/lib:/usr/local/nvidia/lib64
  apt-get update && apt-get install -y --no-install-recommends  \
      libglvnd0 libgl1 libglx0 libegl1 libgles2
  apt-get update && apt-get install -y --no-install-recommends  \
      pkg-config libglvnd-dev libgl1-mesa-dev libegl1-mesa-dev libgles2-mesa-dev
fi
