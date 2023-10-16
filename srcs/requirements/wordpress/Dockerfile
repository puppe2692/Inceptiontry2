FROM debian:buster

RUN apt-get update && apt-get upgrade -y

#installation PHP
RUN apt-get install -y ghostscript \
                php \
                php-bcmath \
                php-curl \
                php-imagick \
                php-intl \
                php-json \
                php-mbstring \
                php-mysql \
                php-xml \
                php-zip \
                php-fpm \
                php-redis \
                wget \
                unzip \
                vim \
                mariadb-client \
                curl \
		netcat

RUN mkdir -p /run/php && \
    mkdir -p /var/www && \
    mkdir -p /var/log/php7-fpm && \
    touch /var/log/php7.3-fpm.log

#installation wordpress
RUN wget https://wordpress.org/latest.zip -O /tmp/wordpress.zip && \
    unzip /tmp/wordpress.zip -d /tmp/wordpress && rm /tmp/wordpress.zip && \
    mv /tmp/wordpress/* /var/www && \
    rmdir /tmp/wordpress

COPY ./wp-config.php /var/www/wordpress

#configuration wordpress
RUN curl https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar -o /tmp/wp-cli.phar && \
    chown www-data:www-data /tmp/wp-cli.phar && \
    chmod +x /tmp/wp-cli.phar && \
    mv /tmp/wp-cli.phar /usr/local/bin/wp

#configuration PHP
COPY ./www.conf /etc/php/7.3/fpm/pool.d/www.conf

RUN chown -R www-data:www-data /run/php && \
    chown -R www-data:www-data /var/www && \
    chown -R www-data:www-data /var/log/php7-fpm && \
    chown    www-data:www-data /var/log/php7.3-fpm.log && \
    chmod -R g+w /var/www/wordpress

#we copy the script, give the right to launch it in local on our computer
COPY docker-entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/docker-entrypoint.sh

#We go the html directory
WORKDIR /var/www/wordpress
USER www-data

#We expose the 9000 port
EXPOSE 9000

#Launch the script
ENTRYPOINT ["docker-entrypoint.sh"]
#Launch PHP FPM in foreground and ignore deamonize from conf file (-F)
CMD ["/usr/sbin/php-fpm7.3", "-F"]
