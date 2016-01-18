FROM ubuntu:15.10
MAINTAINER Pierre Bertet <bonjour@pierrebertet.net>

# Dependencies
RUN apt-get update && \
    apt-get install -y \
        bzr \
        qt5-default \
        liblttng-ctl-dev \
        liblttng-ctl0 \
        liblttng-ust-dev \
        liblttng-ust-ctl2 && \
    apt-get build-dep -y ubuntu-ui-toolkit && \
    rm -rf /var/lib/apt/lists/*

# Create and switch to the user "uitk"
ENV HOME /home/uitk
RUN useradd --create-home --home-dir $HOME uitk && \
    chown -R uitk $HOME
USER uitk
WORKDIR $HOME

COPY docker-entrypoint.sh /docker-entrypoint.sh

ENTRYPOINT ["/docker-entrypoint.sh"]
