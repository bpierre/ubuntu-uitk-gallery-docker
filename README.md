# Ubuntu UITK Gallery - Docker image

Tested on Ubuntu, Debian, and Fedora hosts. OS X support via Docker Machine is planned.

## Installation

### Install Docker (if not already installed)

Either install [Docker](http://docker.com) from the website, or using these commands:

```sh
$ wget -qO- https://get.docker.com/ | sh
$ sudo usermod -aG docker `whoami`
$ sudo service docker start
```

Logout / login again after having completed these steps.

### Download `run-gallery.sh`

```sh
$ curl -OL https://rawgit.com/bpierre/ubuntu-uitk-gallery-docker/master/run-gallery.sh
$ chmod +x ./run-gallery.sh
```

## Usage

The `run-gallery.sh` script will fetch the code, compile the project if needed, and run the gallery app.

Example using the default branch (`lp:ubuntu-ui-toolkit/staging`):

```sh
$ ./run-gallery.sh
```

Example using a specific branch:

```sh
$ ./run-gallery.sh lp:ubuntu-ui-toolkit/trunk
```
