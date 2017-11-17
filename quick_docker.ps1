
#get logs from container

docker start 1b
docker exec 1b cat /root/.npm/_logs/2017-11-09T14_34_19_456Z-debug.log

#enter in container 

docker start 07
docker exec -it 07 /bin/bash
docker run -it node:8.7.0 /bin/bash

#stop container
docker stop a36

#list and remove containers 
docker ls -a
docker rm 28

# comit changes
docker commit 07 majstorki88/drone-node

#list and remove images

docker image ls
docker image rm 07

# tag images, pull and push
docker login
docker tag d97b4d79241d dtr.asseco.rs/asseco/drone-node
docker push majstorki88/drone-node 

#docker prune
docker system prune


#build image from docker file
docker build . -t asseco/docker-agent

#expose port for container
docker run -ti --rm jboss/keycloak -p 8080

#run keycloack with username and pass
docker run -it --expose=8080 -e KEYCLOAK_USER=admin -e KEYCLOAK_PASSWORD=admin jboss/keycloak

#run MSSQL container
docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=banatkikinda' -p 1433:1433 -d microsoft/mssql-server-linux:2017-latest

#run MySQL container
docker run --name some-mysql -e MYSQL_ROOT_PASSWORD=banatkikinda -d mysql:latest
