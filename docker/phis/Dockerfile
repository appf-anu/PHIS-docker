FROM ubuntu:18.04
# docker build --network=docker_frontend --network=docker_backend -t phis:latest .
# docker run --network=docker_frontend --network=docker_backend --volume /home/sven/git/phis/docker/apache/html/:/var/www/html -i -t phis:latest  /bin/bash

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 python3-dev python3-pip python3-setuptools git wget build-essential ssh less emacs libidn2-0 default-jdk zip unzip sudo 

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

# postgres
RUN wget "https://raw.githubusercontent.com/OpenSILEX/docs-community-dev/master/docs/phis_st_dump.sql"
ARG PGPASSWORD=azerty
RUN psql -h postgres -U phis diaphen < phis_st_dump.sql
#RUN rm phis_st_dump.sql

#rdf4j
RUN wget "http://mirror.switch.ch/eclipse/rdf4j/eclipse-rdf4j-2.4.0-sdk.zip"
RUN /usr/bin/unzip eclipse-rdf4j-2.4.0-sdk.zip 
RUN wget "https://raw.githubusercontent.com/OpenSILEX/docs-community-dev/master/docs/oa.rdf"
RUN wget "https://raw.githubusercontent.com/OpenSILEX/docs-community-dev/master/docs/oepo-1.7.owl"
ADD rdf4j.sh rdf4j.sh
RUN cat rdf4j.sh | eclipse-rdf4j-2.4.0/bin/console.sh

RUN git clone https://github.com/OpenSILEX/phis-webapp.git 

# use docker run to open container
# cd phis-webapp
# composer update
# cd ..
# cp -r phis-webapp /var/www/html

	