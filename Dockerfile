FROM ubuntu:15.10
MAINTAINER Pierre Bertet <bonjour@pierrebertet.net>

# Dependencies
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        bzr=2.6.0+bzr6602-2ubuntu4 \
        ca-certificates=20150426ubuntu1 \
        qt5-default=5.4.2+dfsg-2ubuntu9 \
        liblttng-ctl-dev=2.6.0-1ubuntu1 \
        liblttng-ctl0=2.6.0-1ubuntu1 \
        liblttng-ust-dev=2.6.2-2 \
        liblttng-ust-ctl2=2.6.2-2 \
        ttf-ubuntu-font-family=0.83-0ubuntu1 \
    && apt-get build-dep -y ubuntu-ui-toolkit \
    && rm -rf /var/lib/apt/lists/*

# Create and switch to the user "uitk"
ENV HOME /home/uitk
RUN useradd --create-home --home-dir $HOME uitk && \
    chown -R uitk $HOME
USER uitk
WORKDIR $HOME

COPY docker-entrypoint.sh /docker-entrypoint.sh

CMD ["/docker-entrypoint.sh"]
