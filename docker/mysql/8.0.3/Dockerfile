ARG MYSQL8_VERSION=8.0.3
FROM mysql/mysql-server:${MYSQL8_VERSION}

MAINTAINER "ZeroC0D3 Engineer <zeroc0d3.0912@gmail.com>"

ENV MYSQL_ROOT_PASSWORD="password" \
    MYSQL_ROOT_HOST="localhost" \
    MYSQL_DATABASE="laradock_mysql" \
    MYSQL_USER="laradock" \
    MYSQL_PASSWORD="password"

VOLUME /var/lib/mysql

COPY ./docker-entrypoint.sh /usr/local/bin/
COPY ./healthycheck.sh /healthycheck.sh
RUN touch /healthycheck.cnf && chmod 777 /healthycheck.cnf
RUN touch /mysql-init-complete && chmod 777 /mysql-init-complete
RUN ln -sf usr/local/bin/docker-entrypoint.sh /entrypoint.sh # backwards compat

ENTRYPOINT ["docker-entrypoint.sh"]

HEALTHCHECK CMD /healthycheck.sh

EXPOSE 3306
CMD ["mysqld"]