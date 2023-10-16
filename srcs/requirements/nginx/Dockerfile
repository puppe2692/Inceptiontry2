# Version: 1.0

FROM debian:buster

RUN apt-get update && apt-get upgrade
# Outil de gestion/creation de certificat SSL
RUN apt-get install -y nginx openssl

ARG NGINX_DOMAIN
# Dossier permettant de stocker le certif et la cle pour une connexion securisee
RUN mkdir -p "/etc/cert/$NGINX_DOMAIN" && \
    mkdir -p /var/run/nginx && \
    chown -R www-data:www-data /var/run/nginx

# Openssl request certif -x509 -nodes pour sup la demande de mdp cle privee puis adresse de stockage de la dite clef et certif + remplissage de prompt
RUN openssl req -x509 -newkey rsa:4096 -keyout "/etc/cert/$NGINX_DOMAIN/key.pem" -out "/etc/cert/$NGINX_DOMAIN/cert.pem" -sha256 -days 365 -nodes -subj "/CN=$NGINX_DOMAIN"

# Ajout des fichiers de configuration
COPY ./nginx.conf /etc/nginx/nginx.conf
COPY ./wordpress.conf "/etc/nginx/conf.d/$NGINX_DOMAIN.conf"

#remplace \$NGINX_DOMAIN par sa valeur dans tous les fichiers de conf
RUN sed -i "s/\$NGINX_DOMAIN/$NGINX_DOMAIN/g" /etc/nginx/conf.d/*

#demarre nginx en mode non demon
CMD ["nginx", "-g", "daemon off;"]
