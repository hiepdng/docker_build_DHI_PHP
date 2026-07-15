## PHP-FPM Server API using Docker Hardened Image (dhi.io)

This repository is used to create an PHP-fPM server based on PHP [Docker Hardened Image (DHI)]((https://hub.docker.com/hardened-images/catalog/dhi/php)  

Files provided:  
- scripts.sh:
  - Pull httpd.conf and php.init  from dhi.io/php:8.5.8-debian13-dev .
  - You need to modify variables inside the script.sh to approreate modify the php.ini
  - Create mount directory on the host system
- Dockerfile:
  - Used to create your own local image. Modify it if neccessary.
- docker-compose.yml:
  - Used to create the container. Modify it if neccessary.

<br/>

### Pre-configuration:
- Run the script.sh:  
`$ sh script.sh` 

<br/>

### Build the image:
`$ docker build -t dhi.io/php:8.5.8-debian13-fpm .  

### Start httpd image:
```
$ docker compose up -d
```  
or  
```
$ docker run -d --name my-httpd -p 8080:8080  -p 443:443 \  
  -v /home/app/apache2/htdocs:/usr/local/apache2/htdocs \
  dhi.io/httpd:2.4.68-debian13
```

NOTE:
  - This setting use both 8080 and 433 ports for testing. Port 443 is recommended.
  - Check if it works.
    Go to a web browser and enter _http://localhost:8080_ or _https://localhost:443_


### Some other commands:  
```
$ docker logs <container_id_or_name>      – View httpd log
  docker logs my-httpd
$ docker exec -it <containerID> bash      – Go to container shell, for dhi.io/httpd:2.4.68-debian13-dev only
$ docker cp <containerID>:/container/path/file /host/path/file  – Copy file from container to host system
```
      
<br/><br/>

### Basic docker commands:
```
$ docker pull <image_name>       – Pulls an image from dockerhub
$ docker image ls                – Lists all locally stored Docker images on your host system
$ docker run -d <image_name>     – Creates & starts a new Docker container from animage and runs it in the background
  docker run -it -d --name image_name <image_name>
$ docker ps                      – Lists all currently running Docker container IDs on your system
$ docker ps -a                   – lists all Docker container IDs on your system, regardless of their current status. 
$ docker stop <containerID>      – Gracefully shuts down a running Docker container
$ docker start <containerID>     – Resumes and boots up stopped Docker container
$ docker rm <containerID>        – Remove Docker container

$ docker exec -it <containerID> bash – Opens an interactive command-line terminal (Bash) inside a Docker
                                       container that is already running.
```

<br/>
