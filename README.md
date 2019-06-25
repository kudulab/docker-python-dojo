# docker-python-dojo

A Dojo docker image with Python. Based on [official Python image](https://hub.docker.com/_/python/).

## Specification

This image has installed:
 * python (either 2.7 or 3.7, choose particular docker image tag)
 * virtualenv, tox, devpi-client

If you want to use a [devpi server](http://doc.devpi.net), set environment variables:
   * `KUDU_DEVPI_INDEX` - if it is set, then `devpi use --set-cfg --pip-set-trusted=yes "${KUDU_DEVPI_INDEX}"` will be run
   * `KUDU_DEVPI_LOGIN` - if it is set, then `devpi login --password "${KUDU_DEVPI_PASSWORD}" "${KUDU_DEVPI_LOGIN}"` will be run
   * `KUDU_DEVPI_PASSWORD` - may be empty

## Usage
1. Setup docker.
2. Install [Dojo](https://github.com/ai-traders/dojo) binary.
3. Provide a Dojofile:
```
DOJO_DOCKER_IMAGE="kudulab/python-dojo:py3-1.0.0"
# or:
# DOJO_DOCKER_IMAGE="kudulab/python-dojo:py2-1.0.0"
```
4. Create and enter the container by running `dojo` at the root of project.
```bash
dojo "python --help"
```

By default, current directory in docker container is `/dojo/work`.


## Development
### Dependencies
* Bash
* Docker daemon
* Bats
* [Dojo](https://github.com/ai-traders/dojo)


### Lifecycle
1. In a feature branch:
    * you make changes and add some docs to changelog (do not insert date or version)
    * you build docker images: `./tasks build_local_py3`, `./tasks build_local_py2`
    * and test them: `./tasks itest_py3`, `./tasks itest_py2`
    * to test it interactively: `./tasks example`
1. You decide that your changes are ready and you:
    * merge into master branch
    * run locally:
      * `./tasks set_version` to bump the patch version fragment by 1 OR
      * e.g. `./tasks set_version 1.2.3` to bump to a particular version
    * push to master onto private git server
1. CI server (GoCD) tests and releases.

## License

Copyright 2019 Ewa Czechowska, Tomasz Sętkowski

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
