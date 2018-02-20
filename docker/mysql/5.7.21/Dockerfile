ARG MYSQL_VERSION=5.7.21
FROM mysql:${MYSQL_VERSION}

MAINTAINER "ZeroC0D3 Engineer <zeroc0d3.0912@gmail.com>"

ENV MYSQL_ROOT_PASSWORD="gitscrum_password" \
    MYSQL_ROOT_HOST="localhost" \
    MYSQL_DATABASE="gitscrum_mysql" \
    MYSQL_USER="gitscrum_user" \
    MYSQL_PASSWORD="gitscrum_password"

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