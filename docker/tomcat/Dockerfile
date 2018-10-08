FROM ubuntu:18.04

RUN apt-get update && apt-get install -y --no-install-recommends \
    python3 python3-dev python3-pip python3-setuptools git wget build-essential ssh less emacs libidn2-0 default-jdk


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
	



