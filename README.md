# ubuntu-uitk-gallery-docker

## HOWTO

### Install [Docker](http://docker.com)

```sh
$ curl -sSL https://get.docker.com/ | sh
```

### Run the gallery app

`run-gallery.sh` will fetch the code, compile the project if needed, and run the gallery app.

Default branch (`lp:ubuntu-ui-toolkit/staging`):

```sh
$ ./run-gallery.sh
```

Specific branch, e.g. `lp:ubuntu-ui-toolkit/trunk`:

```sh
$ ./run-gallery.sh lp:ubuntu-ui-toolkit/trunk
```
