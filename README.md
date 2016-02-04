# Ubuntu UITK Gallery - Docker image

Tested on Ubuntu, Debian, and Fedora hosts. OS X support via Docker Machine is planned.

## Installation

Download `run-gallery.sh`:

```sh
curl -OL https://rawgit.com/bpierre/ubuntu-uitk-gallery-docker/master/run-gallery.sh
chmod +x ./run-gallery.sh
```

## Usage

The `run-gallery.sh` script will automatically:

- Install Docker if needed (remember to logout / login after this)
- Fetch the code from the selected branch
- Compile the project if needed
- Run the gallery app

Run it without any parameter to use the default branch, `lp:ubuntu-ui-toolkit/staging`:

```sh
./run-gallery.sh
```

To use another branch, pass it as a parameter:

```sh
./run-gallery.sh lp:ubuntu-ui-toolkit/trunk
```

Use the `-g` parameter to change the number of pixels per Grid Unit:

```sh
./run-gallery.sh -g 16
```

Use the `-h` option to display the help:

```
$ ./run-gallery.sh -h
Usage: ./run-gallery.sh [-hcf] [-i DOCKER_IMAGE] [-g GU_PX] [UI_TOOLKIT_BRANCH]

    -h              Display this help and exit.
    -i DOCKER_IMAGE Change the Docker image used to create the containers.
    -g GU_PX        Change the number of pixels per grid unit (to scale
                    things).
    -c              Remove the containers and images created by the script.
    -f              Fix the DNS issue encountered on Ubuntu inside of a virtual machine.
```

## Known Issues

On Ubuntu inside a virtual machine, the DNS resolution inside Docker containers can fail.

To resolve the issue, use the `-f` parameter and follow the instructions:

```
$ ./run-gallery.sh -f
```
