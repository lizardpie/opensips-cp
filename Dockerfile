FROM php:7.1-apache
#FROM php:7.2-apache

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN chmod uga+x /usr/local/bin/install-php-extensions && sync && \
    install-php-extensions pdo_mysql

RUN mkdir -p /var/www/html/opensips-cp
RUN mkdir -p /var/www/html/opensips-cp/web
RUN mkdir -p /var/www/html/opensips-cp/config
RUN mkdir -p /var/www/html/opensips-cp/cron_job

COPY web/ /var/www/html/opensips-cp/web/
COPY config/ /var/www/html/opensips-cp/config/
COPY cron_job/ /var/www/html/opensips-cp/cron_job/

COPY conf/db.inc.php /var/www/html/opensips-cp/config/ 
COPY conf/boxes.global.inc.php /var/www/html/opensips-cp/config/
COPY conf/000-default.conf /etc/apache2/sites-available/000-default.conf

RUN chown -R www-data:www-data /var/www/html/opensips-cp/

RUN /etc/init.d/apache2 restart

EXPOSE 80

