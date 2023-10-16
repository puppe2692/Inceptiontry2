#! /bin/bash
set -e

verify_envs() {
	if [ -z "$MYSQL_DATABASE" -o -z "$MYSQL_USER" -o -z "$MYSQL_USER_PASSWD" -o -z "$MYSQL_HOST" -o -z "$NGINX_DOMAIN" -o -z "$WORDPRESS_ADMIN_USER" -o -z "$WORDPRESS_ADMIN_PASSWD" -o -z "$WORDPRESS_ADMIN_EMAIL" -o -z "$WORDPRESS_SITE_TITLE" -o -z "$WORDPRESS_AUTHOR" -o -z "$WORDPRESS_AUTHOR_EMAIL" -o -z "$WORDPRESS_AUTHOR_PASSWD" ]; then
		cat <<- 'EOF'
		  Can't start the wordpress server without all the env variables:
		    - MYSQL_DATABASE
		    - MYSQL_USER
		    - MYSQL_USER_PASSWD
		    - MYSQL_HOST=mariadb
		    - NGINX_DOMAIN
		    - WORDPRESS_ADMIN_USER
		    - WORDPRESS_ADMIN_PASSWD
		    - WORDPRESS_ADMIN_EMAIL
		    - WORDPRESS_SITE_TITLE
		    - WORDPRESS_AUTHOR
		    - WORDPRESS_AUTHOR_EMAIL
		    - WORDPRESS_AUTHOR_PASSWD
		EOF
		exit 1
	fi
}

setup_wordpress() {
	sed -i "s/\$MYSQL_USER_PASSWD/$MYSQL_USER_PASSWD/g" /var/www/wordpress/wp-config.php
	sed -i "s/\$MYSQL_USER/$MYSQL_USER/g" /var/www/wordpress/wp-config.php
	sed -i "s/\$MYSQL_DATABASE/$MYSQL_DATABASE/g" /var/www/wordpress/wp-config.php
	sed -i "s/\$MYSQL_HOST/$MYSQL_HOST/g" /var/www/wordpress/wp-config.php
	sed -i "s/\$NGINX_DOMAIN/$NGINX_DOMAIN/g" /var/www/wordpress/wp-config.php

	echo "Installing WordPress website..."
	wp core install \
		--allow-root \
		--url="$NGINX_DOMAIN" \
		--title="$WORDPRESS_SITE_TITLE" \
		--admin_user="$WORDPRESS_ADMIN_USER" \
		--admin_password="$WORDPRESS_ADMIN_PASSWD" \
		--admin_email="$WORDPRESS_ADMIN_EMAIL"

	wp user create "$WORDPRESS_AUTHOR" "$WORDPRESS_AUTHOR_EMAIL" \
		--allow-root \
		--role=author \
		--user_pass="$WORDPRESS_AUTHOR_PASSWD"

	echo "Updating WordPress plugins..."
	wp plugin update \
		--allow-root \
		--all

	echo "WordPress theme changed to 'twenty twenty two'"
	wp theme install \
		--allow-root \
		--force \
		--activate twentytwentytwo
		
	touch /var/www/wordpress/done
}

main() {
	if [ ! -e /var/www/wordpress/done ]; then
		verify_envs
		setup_wordpress
	fi
	echo "Running php-fpm on port :9000 ..."
	exec "$@"
}

main "$@"