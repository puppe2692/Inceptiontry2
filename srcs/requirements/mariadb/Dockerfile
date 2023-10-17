# Version: 1.0
FROM debian:buster

# Modifiez la source des paquets pour utiliser un miroir Debian différent
# RUN echo "deb http://deb.debian.org/debian/ buster main" > /etc/apt/sources.list
# RUN echo "deb-src http://deb.debian.org/debian/ buster main" >> /etc/apt/sources.list
# RUN echo "deb http://deb.debian.org/debian/ buster-updates main" >> /etc/apt/sources.list
# RUN echo "deb-src http://deb.debian.org/debian/ buster-updates main" >> /etc/apt/sources.list
# RUN echo "deb http://security.debian.org/ buster/updates main" >> /etc/apt/sources.list
# RUN echo "deb-src http://security.debian.org/ buster/updates main" >> /etc/apt/sources.list

RUN apt update && apt upgrade -y
RUN apt install mariadb-server -y

RUN sed -ie 's/bind-address            = 127.0.0.1/bind-address = 0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf

COPY ./docker-entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

RUN mkdir -p /run/mysqld && chown mysql:mysql /run/mysqld

EXPOSE 3306

# HEALTHCHECK --interval=10s --timeout=3s CMD mysql -e "SELECT 1" || exit 1

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["mysqld_safe"]