FROM ubuntu:latest

MAINTAINER Sven Warris (sven.warris@wur.nl)
MAINTAINER Jennifer de Rue (jennifer.derue@wur.nl)

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 python3-dev python3-pip python3-setuptools git wget build-essential ssh less emacs libidn2-0


#
# CREATE USER
#
ARG USER_UID=1001

RUN echo USER_UID $USER_UID; \
    useradd --uid $USER_UID --create-home --shell /bin/bash phis && \
    echo `echo "phis\nphis\n" | passwd phis` && \
    adduser phis sudo && \
    ln -snf /bin/bash /bin/sh

#
# CHANGE USER
#

USER phis

WORKDIR /home/phis

