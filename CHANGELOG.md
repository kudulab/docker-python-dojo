### 2.0.2 (2024-Feb-06)

* use Dojo image scripts 0.13.0
* limit output from this image init scripts

### 2.0.1 (2024-Jan-31)

* ops: update ssh key on cicd

### 2.0.0 (2024-Jan-30)

* drop support for python2 (breaking change)
* bump python3 to 3.13
* refresh ops scripts (tasks)

### 1.0.2 (2020-Oct-25)

* use dojo 0.10.2 docker image scripts, to make it work on Mac using FUSE docker volume driver
* install newer devpi-client 5.2.1, was 4.4.0

### 1.0.1 (2019-Jun-28)

* fix ownership of ~/.ssh and ~/.gitconfig files

### 1.0.0 (2019-Jun-25)

* make it a public image (remove AIT related functionality)
* new base images: 2.7.16-slim-stretch and 3.7.3-slim-stretch
* support devpi server thanks to the environment variables:
  KUDU_DEVPI_INDEX, KUDU_DEVPI_LOGIN, KUDU_DEVPI_PASSWORD

### 0.4.0 (2019-Feb-04)

* newer releaser and docker-ops
* do not use oversion
* transform from ide docker image to dojo docker image #17139

### 0.3.2 (2019-Jan-17)

* added ait CA cert

### 0.3.1 (2019-Jan-04)

* reproducible builds - build docker image using last version from changelog
* better order of Dockerfile directives (fast to do as last ones)
* remove configs tests (itests are enough)
* pin locustio version or else itests fail

### 0.3.0 (2017-Oct-22)

Split into several images with many python versions (2.7, 3.5).

### 0.2.1 (2017-Apr-28)

* updated readme
* itests: can build and upload python package without redundant complications

### 0.2.0 (2017-Apr-27)

* ensure pretty bash prompt like:
 `ide@9eb0e8c9a0fd(python2-ide):/ide/work$ exit`
* \#10994 add devpi config

### 0.1.1 (2017-Apr-27)

* dev: no ruby

### 0.1.0 (9 February 2017)

Initial release
