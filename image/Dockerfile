FROM ide_configs:temp

COPY apt_01proxy /etc/apt/apt.conf.d/01_proxy

# * software-properties-common - to make add-apt-repository work
# * ssh-client - to run git clone over ssh
# * locale-gen en_US.UTF-8 - so that perl does not complain like: "perl: warning: Setting locale failed."
RUN locale-gen en_US.UTF-8 && \
  apt-get install -y --force-yes --no-install-recommends software-properties-common && \
  add-apt-repository --yes ppa:ubuntu-toolchain-r/test && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends \
  ssh-client python python-dev python-pip
RUN pip install virtualenv tox\
  requests requests_toolbelt locustio 
