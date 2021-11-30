# Image that has cloudsql installed
FROM gcr.io/cloudsql-docker/gce-proxy:1.19.1 as build

# https://github.com/docker-library/wordpress/blob/9ee913eea382b5d79f852a2301d4390904d2e4d2/php7.3/apache/Dockerfile
FROM wordpress:5.8-php7.4-fpm
COPY --from=build /cloud_sql_proxy /cloud_sql_proxy
RUN mkdir config

# custom entrypoint
COPY cloud-run-entrypoint.sh /usr/local/bin/

# permission solution
RUN apt-get update && apt-get install acl -y
WORKDIR /
COPY setuser.sh /
COPY cloud-run-entrypoint.sh /
RUN chmod +x setuser.sh cloud-run-entrypoint.sh

RUN sed -i '/^exec "\$@"/i cd ../../../' /usr/local/bin/docker-entrypoint.sh
RUN sed -i '/^exec "\$@"/i mv setuser.sh /var/www/html/setuser.sh' /usr/local/bin/docker-entrypoint.sh
RUN sed -i '/^exec "\$@"/i cd /var/www/html' /usr/local/bin/docker-entrypoint.sh
RUN sed -i '/^exec "\$@"/i sh setuser.sh' /usr/local/bin/docker-entrypoint.sh

RUN sed -i '/^exec "\$@"/i cd ../../../' /usr/local/bin/docker-entrypoint.sh
RUN sed -i '/^exec "\$@"/i mv cloud-run-entrypoint.sh /usr/local/bin/setuser.sh' /usr/local/bin/docker-entrypoint.sh
RUN sed -i '/^exec "\$@"/i cd /usr/local/bin/' /usr/local/bin/docker-entrypoint.sh
RUN sed -i '/^exec "\$@"/i sh cloud-run-entrypoint.sh' /usr/local/bin/docker-entrypoint.sh

WORKDIR /var/www/html/