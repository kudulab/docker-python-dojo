# docker-python-dojo

A Dojo docker image with Python. Based on [official Python image](https://hub.docker.com/_/python/).

## Specification

This image has installed:
 * python 3
 * virtualenv, tox, devpi-client

If you want to use a [devpi server](http://doc.devpi.net), set environment variables:
   * `KUDU_DEVPI_INDEX` - if it is set, then `devpi use --set-cfg --pip-set-trusted=yes "${KUDU_DEVPI_INDEX}"` will be run
   * `KUDU_DEVPI_LOGIN` - if it is set, then `devpi login --password "${KUDU_DEVPI_PASSWORD}" "${KUDU_DEVPI_LOGIN}"` will be run
   * `KUDU_DEVPI_PASSWORD` - may be empty

## Usage
1. Setup docker.
2. Install [Dojo](https://github.com/kudulab/dojo) binary.
3. Provide a Dojofile:
```
DOJO_DOCKER_IMAGE="kudulab/python-dojo:2.0.1"
# or:
# DOJO_DOCKER_IMAGE="kudulab/python-dojo:latest"
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


## Contributing
Instructions how to update this project.

1. Create a new feature branch from the main branch
1. Work on your changes in that feature branch. If you want, describe you changes in [CHANGELOG.md](CHANGELOG.md)
1. Build your image locally to check that it succeeds: `./tasks build`
1. Test your image locally: `./tasks itest`. You may need to install the test framework - you can do it following [these instructions](https://github.com/kudulab/docker-terraform-dojo/blob/master/tasks#L66)
1. If you are happy with the results, create a PR from your feature branch to master branch

After this, someone will read your PR, merge it and ensure version bump (using `./tasks set_version`). CI pipeline will run to automatically build and test docker image, release the project and publish the docker image.

## License

Copyright 2019-2024 Ava Czechowska, Tom Sętkowski

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
