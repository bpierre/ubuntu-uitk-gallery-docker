# Ubuntu UITK Gallery - Docker image

Tested on Ubuntu, Debian, and Fedora hosts. OS X support via Docker Machine is planned.

## Installation

Download `gallery` and make it executable:

```sh
curl -L https://goo.gl/Of6MEj > gallery && chmod +x ./gallery
```

## Usage

The `gallery` tool will automatically:

- Install Docker if needed (remember to logout / login after this)
- Fetch the code from the selected branch
- Compile the project if needed
- Run the gallery app

Run it without any parameter to use the default branch, `lp:ubuntu-ui-toolkit/staging`:

```sh
./gallery
```

To use another branch, pass it as a parameter:

```sh
./gallery lp:ubuntu-ui-toolkit/trunk
```

Use the `-g` parameter to change the number of pixels per Grid Unit:

```sh
./gallery -g 16
```

Use the `-h` option to display the help:

```
$ ./gallery -h

Usage: ./gallery [-hc] [-i DOCKER_IMAGE] [-g GU_PX] [UI_TOOLKIT_BRANCH]

    -h              Display this help and exit.
    -i DOCKER_IMAGE Change the Docker image used to create the containers.
    -g GU_PX        Change the number of pixels per grid unit (to scale
                    things).
    -c              Remove the containers and images created by the tool.
```
