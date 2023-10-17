FROM debian:buster

RUN apt-get update && apt-get upgrade -y
RUN apt-get install mariadb-server mariadb-client procps -y

RUN sed -ie 's/bind-address            = 127.0.0.1/bind-address = 0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf

RUN mkdir -p /var/run/mysqld && chown mysql:mysql /var/run/mysqld

COPY conf/50-server.cnf	/etc/mysql/mariadb.conf.d/50-server.cnf


COPY ./docker-entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

EXPOSE 3306

#USER mysql
HEALTHCHECK --interval=10s --timeout=3s CMD mysql -e "SELECT 1" || exit 1

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["mysqld"]
