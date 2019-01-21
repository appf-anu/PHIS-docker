# NPEC PHIS installation, documentation and development files

For more information, please contact Jennifer de Rue or Sven Warris.

## Installing services
 
To install and run PHIS, execute these commands:

```{bash}
git clone https://git.wur.nl/NPEC/phis.git
cd phis/docker
docker-compose up -d
```

This will create 4 volumes to store database data and web server configurations. It will launch images for the tomcat web service, apache php web application, mongodb and postgresql. Adminer is installed to access the postgresql database. Docker networks 'frontend' and 'backend' are also activated. 

To access the API, please add 'tomcat' as alias to localhost.

## Installing PHIS configuration, web service and application

Run docker build:

```{bash}
cd phis
docker build --network=docker_frontend --network=docker_backend -t phis:latest .
```

Now enter interactive shell:

```{bash}
docker run --network=docker_frontend --network=docker_backend \ 
	--volume docker_web_data:/var/www/html \ 
	--volume docker_tomcat_conf:/tomcat/conf \ 
	--volume docker_tomcat_webapps:/tomcat/webapps \ 
	-i -t phis:latest  /bin/bash
```

From this shell run these commands:

```{bash}
cd phis-webapp
composer update
sed -i 's/localhost:8084\/phis-ws\/rest/tomcat:8080\/phis2ws\/rest/g' config/*.php
sed -i 's/localhost:8084\/phis2ws/tomcat:8080\/phis2ws/g' config/*.php
sed -i 's/localhost/php/g' config/*.php
cd ..
sudo cp -r phis-webapp /var/www/html
sudo chown -R www-data:www-data /var/www/html 

sudo cp /home/phis/phis-ws/phis2-ws/target/phis2ws-v0.1.war /tomcat/webapps/phis2ws.war
sudo cp /home/phis/tomcat/webapps/*war /tomcat/webapps/
sudo cp /home/phis/tomcat/conf/tomcat-users.xml /tomcat/conf/
sudo cp /home/phis/tomcat/webapps/manager/META-INF/context.xml /tomcat/webapps/manager/META-INF/
sudo cp /home/phis/tomcat/conf/catalina.properties /tomcat/conf/catalina.properties
```

Please provide tokens and password (*phis*) when requested.

Restart services outside container:

```{bash}
docker-compose restart php tomcat
```

In PHIS interactive shell, add repository:

```{bash}
cat rdf4j.sh | eclipse-rdf4j-2.4.1/bin/console.sh
```

Now these services are available:

For local hosts

API - http://tomcat:8080/phis2ws
Webapp - http://localhost/phis-webapp/ 

For remote hosts

API - http://<servername>:8080/phis2ws
Webapp - http://<servername>/phis-webapp/


-



