# Version: 1.0

FROM debian:buster

RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y wget \
                       php \
                       php-mysql \
                       php-fpm \
                       php-common \
                       php-cli \
                       php-json \
                       php-opcache \
                       php-readline

RUN mkdir -p /run/php && \
    mkdir -p /var/www/adminer && \
    mkdir -p /var/log/php7-fpm && \
    touch /var/log/php7.3-fpm.log

ADD https://www.adminer.org/latest.php /var/www/adminer/index.php
ADD https://raw.githubusercontent.com/pepa-linha/Adminer-Design-Dark/master/adminer.css /var/www/adminer/adminer.css

COPY ./www.conf /etc/php/7.3/fpm/pool.d/www.conf
COPY ./docker-entrypoint.sh /usr/local/bin/docker-entrypoint.sh

RUN chmod +x /usr/local/bin/docker-entrypoint.sh && \
    chown -R www-data:www-data /var/www/adminer && \
    chown -R www-data:www-data /var/log/php7-fpm && \
    chown -R www-data:www-data /run/php && \
    chown    www-data:www-data /var/log/php7.3-fpm.log

WORKDIR /var/www/adminer
USER www-data

EXPOSE 3306

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["/usr/sbin/php-fpm7.3", "-F"]
