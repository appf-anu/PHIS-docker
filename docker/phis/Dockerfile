FROM ubuntu:18.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 python3-dev python3-pip python3-setuptools git wget build-essential ssh less emacs libidn2-0 default-jdk


# MongoDB
ARG DEBIAN_FRONTEND=noninteractive
RUN apt-get install -y tzdata
RUN ln -fs /usr/share/zoneinfo/Europe/Amsterdam /etc/localtime
RUN dpkg-reconfigure --frontend noninteractive tzdata

RUN apt-get install -y gnupg2
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
RUN echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.0 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.0.list
RUN apt-get update
RUN apt-get install -y mongodb-org

# Postgresql
RUN apt-get install -y postgresql
RUN apt-get install -y postgis

#PHP + Apache
RUN apt-get install -y  php php-mbstring php-dom apache2 libapache2-mod-php

# Tomcat
RUN groupadd tomcat
RUN useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat
RUN cd /tmp
RUN wget "http://apache.redkiwi.nl/tomcat/tomcat-9/v9.0.12/bin/apache-tomcat-9.0.12.tar.gz" && \ 
	mkdir /opt/tomcat && \
	tar xzvf apache-tomcat-9*tar.gz -C /opt/tomcat --strip-components=1 && \
	cd /opt/tomcat &&\
	chgrp -R tomcat /opt/tomcat && \
	chmod -R g+r conf && \
	chmod g+x conf && \
	chown -R tomcat webapps/ work/ temp/ logs/ && \
	rm -rf apache*
	
ADD tomcat.service /etc/systemd/system/tomcat.service
ADD tomcat-users.xml /opt/tomcat/opt
	
RUN apt-get install -y zip
RUN cd /tmp && \
	wget "http://www.eclipse.org/downloads/download.php?file=/rdf4j/eclipse-rdf4j-2.4.0-sdk.zip&r=1" -O eclipse-rdf4j-2.4.0-sdk.zip && \
	unzip eclipse-rdf4j-2.4.0-sdk.zip && \
	cp eclipse-rdf4j-2.4.0/war/* /opt/tomcat/webapps/ && \
	rm -rf eclipse*
	
# Composer
RUN apt-get install -y curl php-cli php-mbstring
RUN curl -sS https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/local/bin --filename=composer

RUN apt-get install -y sudo 

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
	
#EXPOSE 80 8080
#CMD sudo service mongod start
#CMD sudo service apache2 start
#CMD sudo service postgresql start
#CMD sudo systemctl start tomcat



