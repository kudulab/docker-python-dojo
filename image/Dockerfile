FROM docker-registry.ai-traders.com/python2-ide:temp

COPY apt_01proxy /etc/apt/apt.conf.d/01_proxy

# * software-properties-common - to make add-apt-repository work
# * ssh-client - to run git clone over ssh
# * locale-gen en_US.UTF-8 - so that perl does not complain like: "perl: warning: Setting locale failed."
RUN locale-gen en_US.UTF-8 && \
  apt-get install -y --force-yes software-properties-common && \
  add-apt-repository --yes ppa:ubuntu-toolchain-r/test && \
  apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends \
  ssh-client build-essential python python-dev python-pip
RUN pip install virtualenv tox
COPY virtualenvs_requirements /tmp/virtualenvs_requirements
RUN cd /tmp/virtualenvs_requirements/locust &&\
  virtualenv /ide/virtualenvs/locust &&\
  . /ide/virtualenvs/locust/bin/activate &&\
  pip install -r requirements.txt
RUN chown ide:ide -R /ide/virtualenvs

RUN pip install devpi-client==3.0.0
# ensure pretty bash prompt
COPY bashrc /home/ide/.bashrc
