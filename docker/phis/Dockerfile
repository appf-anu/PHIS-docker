FROM ubuntu:18.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 python3-dev python3-pip python3-setuptools git wget build-essential ssh less emacs libidn2-0 default-jdk zip sudo 

ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y tzdata
RUN ln -fs /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata
RUN apt-get install -y postgresql-client
	
# Composer
RUN apt-get install -y curl php-cli php-mbstring
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer

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

# Composer
RUN composer global require "fxp/composer-asset-plugin:^1.2.0"

RUN wget "https://github.com/OpenSILEX/docs-community-dev/blob/master/docs/phis_st_dump.sql"
RUN psql -h postgres -U phis diaphen < phis_st_dump.sql
RUN rm phis_st_dump.sql



	