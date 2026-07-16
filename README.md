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

### Step 1: Pre-configuration
- Run the script.sh:  
`$ sh script.sh`

### Step 2: Building a PHP-FPM image
`$ docker build -t dhi.io/php:8.5.8-debian13-fpm .`   

### Step 3: Runing a PHP-FPM container
`$ docker run --rm -v /home/app/php:/var/www/html/ dhi.io/php:8.5.8-debian13-fpm`  
or  
`$ docker run --rm -v $(pwd):/app -w /app dhi.io/php:8.5.8-debian13-fpm`  
or  
`$ docker compose up -d`  

<br/><br/>

### Testing/Debugging:
We use two images for Docker multi-stage builds:
  - dhi.io/php:8.5.8-debian13-dev
  - dhi.io/php:8.5.8-debian13-fpm  
Below are some basic commands how to test/debug both images:

- **Testing:**
```
-For dhi.io/php:8.5.8-debian13-dev image:
$ docker run -it --rm -v "$PWD":/app -w /app dhi.io/php:8.5.8-debian13-dev              #Running the container
$ docker run -it --rm -v "$PWD":/app -w /app dhi.io/php:8.5.8-debian13-dev script.php   #Run script.php, or
$ docker exec -it <containerID> script.php                                              #Run script.php

-For dhi.io/php:8.5.8-debian13-fpm image:
$ docker run --rm -v $(pwd):/app -w /app -p 9000:9000 dhi.io/php:8.5.8-debian13-fpm     #Running the container
$ SCRIPT_FILENAME=script.php REQUEST_METHOD=GET cgi-fcgi -bind -connect 127.0.0.1:9000  #run script.php
```
  

- **Debugging:**
```
-For dhi.io/php:8.5.8-debian13-dev image
$ docker run -it --rm -v "$PWD":/app -w /app dhi.io/php:8.5.8-debian13-dev     #Running the container
$ docker debug <containerID>                                                   #Container debug mode
$ docker exec -it <containerID> bash                                           #Container shell mode
$ $ docker run --rm -it --entrypoint /bin/bash dhi.io/php:8.5.8-debian13-dev   #Container shell mode

$ docker run --rm dhi.io/php:8.5.8-debian13-dev -v       #Show php vertion
$ docker run --rm dhi.io/php:8.5.8-debian13-dev -m       #List all php extensions



-For dhi.io/php:8.5.8-debian13-fpm image
$ docker run -it --rm -v "$PWD":/app -w /app dhi.io/php:8.5.8-debian13-fpm       #Running the container
$ docker debug <containerID>                                                     #Debug mode

$ docker run --rm -it -v $(pwd):/app -w /app dhi.io/php:8.5.8-debian13-fpm  -t   #Testing php-fpm.conf

$ docker run --rm dhi.io/php:8.5.8-debian13-fpm -v       #Show php-fpm vertion
$ docker run --rm dhi.io/php:8.5.8-debian13-fpm -m       #List all php-fpm extensions
`````

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
