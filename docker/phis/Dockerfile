FROM ubuntu:18.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 python3-dev python3-pip python3-setuptools git wget build-essential ssh less emacs libidn2-0 default-jdk zip sudo 
	
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

# Robo3T
RUN wget https://download.robomongo.org/1.2.1/linux/robo3t-1.2.1-linux-x86_64-3e50a65.tar.gz && \
	tar zxvf robo3t-1.2.1-linux-x86_64-3e50a65.tar.gz && \
	rm robo3t-1.2.1-linux-x86_64-3e50a65.tar.gz

	