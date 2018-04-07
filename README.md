# Docker-GitScrum
Docker containers for Laravel GitScrum

## Configuration Environment
* Change `.env.example` file to `.env` for Docker environment configuration

## Setup Docker Builder Script
* Change docker build & running environment in `run.sh` file
  - ENV="0"  # (0 = development, 1 = production)
* Setup for containers
  - CONTAINER_PRODUCTION="nginx mysql phpfpm-gitscrum adminer"     # (using mysql database container for production environment)
  - CONTAINER_DEVELOPMENT="nginx mariadb phpfpm-gitscrum adminer"  # (using mariadb database container for development environment)
* Setup cache containers
  - REMOVE_CACHE="0" # (0 = using cache (default), 1 = no-cache)
* Setup recreate containers every running docker-compose
  - RECREATE_CONTAINER="0"  # (0 = disable recreate container, 1 = force recreate container)
* Setup running build containers or not.
  - SKIP_BUILD="0"   # (0 = with build process (default), 1 = bypass build process)
* Setup running background (daemon mode)
  - DAEMON_MODE="0"  # (0 = disable daemon mode, 1 = running daemon mode / background)

## Select Database
* If you're using MySQL, change file `docker-compose-mysql.yml` to `docker-compose.yml`
* If you're using MariaDB, change file `docker-compose-mariadb.yml` to `docker-compose.yml`

## Configuration Gitscrum Laravel
* Open terminal in this "workspace" folder
* Clone or Download Gitscrum repository inside "workspace" folder
```
git clone git@github.com:gitscrum-community-edition/laravel-gitscrum.git
```

## Running Docker
You can run the command on your bash to run docker
```
./run.sh
```

## Default Configuration
* MySQL
```
MYSQL_ROOT_PASSWORD=password
MYSQL_ROOT_HOST=localhost
MYSQL_DATABASE=gitscrum_mysql
MYSQL_USER=gitscrum
MYSQL_PASSWORD=password
MYSQL_PORT=33061
```
* MariaDB
```
MARIADB_ROOT_PASSWORD=password
MARIADB_ROOT_HOST=localhost
MARIADB_DATABASE=gitscrum_mariadb
MARIADB_USER=gitscrum
MARIADB_PASSWORD=password
MARIADB_PORT=33062
```

## Using Adminer (Web Admin Tool)
* Check for docker container status
```
docker ps
```
```
CONTAINER ID        IMAGE                            COMMAND                  CREATED             STATUS                           PORTS                     NAMES
abf37f719057        dockergitscrum_nginx             "nginx -g 'daemon ..."   9 minutes ago       Up 9 minutes                     0.0.0.0:8085->80/tcp      dockergitscrum_nginx_1
0ac4a0290853        dockergitscrum_phpfpm-gitscrum   "docker-php-entryp..."   10 minutes ago      Restarting (78) 18 seconds ago                             dockergitscrum_phpfpm-gitscrum_1
64a3cd97eec2        dockergitscrum_mariadb           "docker-entrypoint..."   10 minutes ago      Up 10 minutes (unhealthy)        0.0.0.0:33062->3306/tcp   dockergitscrum_mariadb_1
73c65ce075ad        dockergitscrum_adminer           "entrypoint.sh doc..."   12 minutes ago      Up 12 minutes                    0.0.0.0:8080->8080/tcp    dockergitscrum_adminer_1
```

* Check IP docker container (MySQL / MariaDB)
```
docker inspect 64a3cd97eec2 | grep IPAddress
```
```
...
"IPAddress": "172.24.0.2"
```

* Using MySQL
```
System   : MySQL
Server   : 172.24.0.2          # "IPAddress": "172.24.0.2"
Username : gitscrum
Password : gitscrum_password
Database : gitscrum_mysql
```

* Using MariaDB
```
System   : MySQL
Server   : 172.24.0.2          # "IPAddress": "172.24.0.2"
Username : gitscrum
Password : gitscrum_password
Database : gitscrum_mariadb
```

## How to install Docker Compose
[Docker Compose](https://docs.docker.com/compose/install/)

