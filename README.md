# docker-python2-ide

An IDE docker image with python. Based on ubuntu:14.04.5.

## Specification

This image has installed:
 * python, python-dev, python-pip
 * virtualenv, tox?

## Usage
1. Install [IDE](https://github.com/ai-traders/ide)
2. Provide an Idefile:
```
IDE_DOCKER_IMAGE="docker-registry.ai-traders.com/python2-ide:0.2.1"
```

By default, current directory in docker container is `/ide/work`.

### Commands
First run this to **generate an example Idefile** which uses latest released docker image:
```
./tasks example
```
Then run all the commands in ide docker image:
```
ide --idefile Idefile.example
```
Thanks to this example environment, we use **pre-generated IDE_WORK directory with example python package** taken from: http://doc.devpi.net/latest/userman/devpi_packages.html

#### List (published) package versions
```
devpi list simplejson
```
#### Install python package
```
source /ide/virtualenvs/locust/bin/activate
pip install simplejson
```
```
source /ide/virtualenvs/locust/bin/activate
pip install -r requirements2.txt
```
#### Build python package
```
cd example-pythonide2
python setup.py sdist
```
#### Upload python package
```
cd example-pythonide2
devpi upload dist/example-pythonide2-1.22.5.tar.gz
```
You can upload all the release files from a directory: `devpi upload --from-dir some_package/dist`

#### Other commands
* [devpi test](http://doc.devpi.net/latest/quickstart-releaseprocess.html#devpi-test-testing-an-uploaded-package)
* all the [devpi commands](http://doc.devpi.net/latest/userman/devpi_commands.html)

### Configuration
Those files are used inside the ide docker image:

1. `~/.ssh/config` -- will be generated on docker container start
2. `~/.ssh/id_rsa` -- it must exist locally, because it is a secret
 (but the whole `~/.ssh` will be copied)
2. `~/.gitconfig` -- if exists locally, will be copied
3. `~/.profile` -- will be generated on docker container start, in
   order to ensure current directory is `/ide/work`.

## Development
### Dependencies
* Bash
* Docker daemon
* Bats
* Ide

### Tests
There are 2 Dockerfiles:
  * Dockerfile_ide_configs -- to test IDE configuration files and fail fast
  * Dockerfile -- to build the main ide image, based on image built from
   Dockerfile_ide_configs

### Lifecycle
1. In a feature branch:
    * you make changes and add some docs to changelog (do not insert date or version)
    * you build docker image with ide configs: `./tasks build_cfg`
    * you test docker image with ide configs: `./tasks test_cfg`
    * you build docker image: `./tasks build`
    * and test it: `./tasks itest`
1. You decide that your changes are ready and you:
    * merge into master branch
    * run locally:
      * `./tasks bump` to bump the patch version fragment by 1 OR
      * e.g. `./tasks bump 1.2.3` to bump to a particular version
        Version is bumped in Changelog, variables.sh file and OVersion backend
    * push to master onto private git server
1. CI server (GoCD) tests and releases.
