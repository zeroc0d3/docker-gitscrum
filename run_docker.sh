#!/usr/bin/env sh
# ------------------------------------------------
#  DOCKER BUILDER SCRIPT
# -------------------------------------------------
#  Author     : ZeroC0D3 Engineer (@zeroc0d3)
#  Repository : https://github.com/zeroc0d3/docker-lab
#  License    : MIT
# -------------------------------------------------

TITLE="DOCKER BUILDER SCRIPT"        # script name
VER="1.4"                            # script version
ENV="0"                              # (0 = development / 1 = production)
REMOVE_CACHE="0"                     # (0 = using cache, 1 = no-cache)
RECREATE_CONTAINER="0"               # (0 = disable recreate container, 1 = force recreate container)
SKIP_BUILD="0"                       # (0 = with build process, 1 = bypass build process)
DAEMON_MODE="0"                      # (0 = disable daemon mode, 1 = running daemon mode / background)

## Using MySQL (Default) ###
CONTAINER_PRODUCTION="nginx mysql phpfpm-gitscrum adminer"
CONTAINER_DEVELOPMENT="nginx mysql phpfpm-gitscrum adminer"

## Using MariaDB ###
# CONTAINER_PRODUCTION="nginx mariadb phpfpm-gitscrum adminer"
# CONTAINER_DEVELOPMENT="nginx mariadb phpfpm-gitscrum adminer"

export DOCKER_CLIENT_TIMEOUT=300
export COMPOSE_HTTP_TIMEOUT=300

get_time() {
  DATE=`date '+%Y-%m-%d %H:%M:%S'`
}

logo() {
  clear
  echo "\033[22;32m==========================================================================\033[0m"
  echo "\033[22;31m           .__  __                                      DOCKER BUILDER    \033[0m"
  echo "\033[22;31m      ____ |__|/  |_  ______ ___________ __ __  _____   ver-$VER          \033[0m"
  echo "\033[22;31m     / ___\|  \   __\/  ___// ___\_  __ \  |  \/     \                    \033[0m"
  echo "\033[22;31m    / /_/  >  ||  |  \___ \\  \___|  | \/  |  /  Y Y  \                   \033[0m"
  echo "\033[22;31m    \___  /|__||__| /____  >\___  >__|  |____/|__|_|  /                   \033[0m"
  echo "\033[22;31m   /_____/               \/     \/                  \/                    \033[0m"
  echo "\033[22;32m--------------------------------------------------------------------------\033[0m"
  echo "\033[22;32m# $TITLE :: ver-$VER                                                      \033[0m"
}

header() {
  logo
  echo "\033[22;32m==========================================================================\033[0m"
  get_time
  echo "\033[22;37m# BEGIN PROCESS..... (Please Wait)  \033[0m"
  echo "\033[22;33m# Start at: $DATE  \033[0m\n"
}

footer() {
  echo "\033[22;32m==========================================================================\033[0m"
  get_time
  echo "\033[22;33m# Finish at: $DATE  \033[0m"
  echo "\033[22;37m# END PROCESS.....  \033[0m\n"
}

build_env() {
  if [ "$ENV" = "0" ]
  then
    BUILD_ENV="$CONTAINER_DEVELOPMENT"
  else
    BUILD_ENV="$CONTAINER_PRODUCTION"
  fi
}

cache() {
  if [ "$REMOVE_CACHE" = "0" ]
  then
    CACHE=""
  else
    CACHE="--no-cache"
  fi
}

recreate() {
  if [ "$RECREATE_CONTAINER" = "0" ]
  then
    RECREATE=""
  else
    RECREATE="--force-recreate"
  fi
}

daemon_mode() {
  if [ "$DAEMON_MODE" = "0" ]
  then
    DAEMON=""
  else
    DAEMON="-d"
  fi
}

docker_build() {
  if [ "$SKIP_BUILD" = "0" ]
  then
    echo "--------------------------------------------------------------------------"
    get_time
    echo "\033[22;34m[ $DATE ] ##### Docker Compose: \033[0m                        "
    echo "\033[22;32m[ $DATE ]       docker-compose build $CACHE $BUILD_ENV \033[0m\n"
    for CONTAINER in $BUILD_ENV
    do
      get_time
      echo "--------------------------------------------------------------------------"
      echo "\033[22;32m[ $DATE ]       docker-compose build $CONTAINER \033[0m        "
      echo "--------------------------------------------------------------------------"
      docker-compose build $CONTAINER
      echo ""
    done
  fi
}

docker_up() {
  daemon_mode
  echo ""
  echo "--------------------------------------------------------------------------"
  get_time
  echo "\033[22;34m[ $DATE ] ##### Docker Compose Up: \033[0m                     "
  echo "\033[22;32m[ $DATE ]       docker-compose up $RECREATE $BUILD_ENV \033[0m\n"
  get_time
  echo "--------------------------------------------------------------------------"
  echo "\033[22;32m[ $DATE ]       docker-compose up $RECREATE $BUILD_ENV \033[0m "
  echo "--------------------------------------------------------------------------"
  docker-compose up $DAEMON $RECREATE $BUILD_ENV
  echo ""
}

main() {
  header
  cache
  recreate
  build_env
  docker_build
  docker_up
  footer
}

### START HERE ###
main