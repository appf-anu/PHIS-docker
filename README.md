# ANU PHIS installation, documentation and development files

## Installing services
 
To install and run PHIS, execute these commands:

```{bash}
git clone https://github.com/appf-anu/PHIS-docker.git
cd PHIS-docker
docker-compose up -d
```

This will create volumes to store database data and web server configurations. 
It will launch images for the tomcat web service, apache php web application, rdf4j, mongodb and postgresql. 
Docker networks 'frontend' and 'backend' are also activated. 

# Initialize databases

Once all services are up and running execute the following command the first time to populate database:

```
docker exec -it --user root rdf4j /bin/bash /tmp/seed-data.sh
docker exec -it postgres /bin/bash /tmp/seed-data.sh
```
