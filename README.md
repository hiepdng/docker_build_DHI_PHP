## PHP-FPM Server API using Docker Hardened Image (dhi.io)

### Introduction:
This repository is used to create an PHP-FPM server based on PHP [Docker Hardened Image (DHI)](https://hub.docker.com/hardened-images/catalog/dhi/php)  

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

### Build a PHP-FPM image:
`$ docker build -t dhi.io/php:8.5.8-debian13-fpm .`  
or  
`$ docker compose up -d`  

### Run a PHP script.php
`$ docker run --rm -v /home/app/php:/var/www/html/ dhi.io/php:8.5.8-debian13-fpm php script.php`  
or  
`$ docker run --rm -v $(pwd):/app -w /app dhi.io/php:8.5.8-debian13-fpm php script.php`  

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
