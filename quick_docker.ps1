
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