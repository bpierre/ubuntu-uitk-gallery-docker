# Ubuntu UITK Gallery - Docker image

## Installation

### Install [Docker](http://docker.com)

From the website or using this command:

```sh
$ curl -sSL https://get.docker.com/ | sh
```

Add your user to the docker group:

```sh
$ sudo usermod -aG docker `whoami`
```

Start the docker daemon:

```sh
$ sudo service docker start
```

### Download `run-gallery.sh`

```sh
$ curl -OL https://rawgit.com/bpierre/ubuntu-uitk-gallery-docker/master/run-gallery.sh
$ chmod +x ./run-gallery.sh
```

## Usage

`run-gallery.sh` will fetch the code, compile the project if needed, and run the gallery app.

Default branch (`lp:ubuntu-ui-toolkit/staging`):

```sh
$ ./run-gallery.sh
```

Specific branch, e.g. `lp:ubuntu-ui-toolkit/trunk`:

```sh
$ ./run-gallery.sh lp:ubuntu-ui-toolkit/trunk
```
