
#get logs from container

docker start 17
docker exec 17 cat /root/.npm/_logs/2017-11-09T14_34_19_456Z-debug.log
docker exec 17 cat /root/.npm/_logs/2017-11-09T14_34_19_456Z-debug.log

#enter in container 

docker start 17;
docker exec -it 17 /bin/bash
docker run -it node:8.7.0 /bin/bash
docker run -it microsoft/mssql-server-linux:2017-latest /bin/bash
docker run -d -ti -p 80:80 -v ~/sph/laravel52:/www/laravel ubuntu

docker run -d -it -p 80:80 -v /var/run/docker.socket:/var/run/docker.socket
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

# Remove all images and containers 
#Containers
docker rm $(docker ps -a -q)
#Images
docker rmi $(docker images -q)
#Volumes 
docker volume rm $(docker volume ls)

# tag images, pull and push
docker login
docker tag 5f0b6b72939f dtr.asseco.rs/asseco/docker-api
docker push dtr.asseco.rs/asseco/docker-api

docker tag b5e9674e81f5 majstorki88/dotnet
docker push majstorki88/dotnet

#docker prune
docker system prune


#build image from docker file
docker build . -t asseco/docker-api

#expose port for container
docker run -ti --rm jboss/keycloak -p 8080

#run keycloack with username and pass
docker run -it -p 8080:8080 -e KEYCLOAK_USER=admin -e KEYCLOAK_PASSWORD=admin jboss/keycloak
#keycloak must enable

#run MSSQL container
docker run -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=BanatKikinda1988#' -p 1433:1433 -d microsoft/mssql-server-linux:2017-latest


#run MySQL container
docker run --name mysql -p 3306:3306 -e MYSQL_ROOT_PASSWORD=banatkikinda -d mysql:latest

# run POSTGRES
docker run --name postgres -e POSTGRES_PASSWORD=banatkikinda -p 5432:5432 -d postgres 

https://hub.docker.com/_/postgres/

#run Oracle DB 12.0.2
mkdir git-repos
cd git-repos
git clone https://github.com/oracle/docker-images.git
#download install files - linuxx64_12201_database.zip form Oracle - http://www.oracle.com/technetwork/database/enterprise-edition/downloads/index.html
#copy install files to repository on location docker-images/dockerfiles/12.2.0.1
mv linuxx64_12201_database.zip git_repos/docker-images/OracleDatabase/dockerfiles/12.2.0.1/
#unzip binaries
cd git-repos/docker-images/OracleDatabase/dockerfiles/12.2.0.1/
unzip linuxx64_12201_database.zip
# run build scripts from dockerfiles
cd git-repos/docker-images/OracleDatabase/dockerfiles
./buildDockerImage.sh -h
./buildDockerImage.sh -v 12.2.0.1 -e -i

#install portainer

docker run -d -p 9000:9000 -v /var/run/docker.sock:/var/run/docker.sock -v /opt/portainer:/data portainer/portainer

docker run -d -v /var/run/docker.sock:/var/run/docker.sock -v /bin/bash:/bin/bash --privileged image_dotnet_api_test

/sbin/route



docker run -d -p 8090:80 -v /var/run/docker.sock:/var/run/docker.sock -v /sbin/route:/sbin/route -v /bin/bash:/bin/bash dtr.asseco.rs/asseco/docker-api