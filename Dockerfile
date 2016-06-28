FROM php:5.6-apache
MAINTAINER Mathias Gebbe <mathias.gebbe@gmail.com>
ENV MYSQL_PASSWORD password

COPY php.ini /usr/local/etc/php/

RUN apt-get update && \
    apt-get install -y vim \
    curl \
    unzip

RUN docker-php-ext-install mysql

RUN cd /var/www && curl -L -Os https://sourceforge.net/projects/phpscheduleit/files/latest/booked-2.5.20.zip && \
    unzip booked-2.5.20.zip && \
    chown www-data: /var/www/booked -R && \
    chmod 0755 /var/www/booked -R && \
    cp booked/config/config.dist.php booked/config/config.php && \
    sed -i 's,127.0.0.1,mysql,g' /var/www/booked/config/config.php && \
    sed -i 's,$conf['settings']['database']['password'] = 'password';,$conf['settings']['database']['password'] = '$MYSQL_PASSWORD';,g' /var/www/booked/config/config.php

RUN cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/booked.conf && \
    sed -i 's,/var/www/html,/var/www/booked,g' /etc/apache2/sites-available/booked.conf && \
    sed -i 's,${APACHE_LOG_DIR},/var/log/apache2,g' /etc/apache2/sites-available/booked.conf && \
    a2ensite booked.conf

WORKDIR /var/www/booked

EXPOSE 80 443

CMD ["apache2-foreground"]
#ENTRYPOINT ["/bin/bash"]
cat: cat: Datei oder Verzeichnis nicht gefunden
FROM php:5.6-apache
MAINTAINER Mathias Gebbe <mathias.gebbe@gmail.com>
ENV MYSQL_PASSWORD password

COPY php.ini /usr/local/etc/php/

RUN apt-get update && \
    apt-get install -y vim \
    curl \
    unzip

RUN docker-php-ext-install mysql

RUN cd /var/www && curl -L -Os https://sourceforge.net/projects/phpscheduleit/files/latest/booked-2.5.20.zip && \
    unzip booked-2.5.20.zip && \
    chown www-data: /var/www/booked -R && \
    chmod 0755 /var/www/booked -R && \
    cp booked/config/config.dist.php booked/config/config.php && \
    sed -i 's,127.0.0.1,mysql,g' /var/www/booked/config/config.php && \
    sed -i 's,$conf['settings']['database']['password'] = 'password';,$conf['settings']['database']['password'] = '$MYSQL_PASSWORD';,g' /var/www/booked/config/config.php

RUN cp /etc/apache2/sites-available/000-default.conf /etc/apache2/sites-available/booked.conf && \
    sed -i 's,/var/www/html,/var/www/booked,g' /etc/apache2/sites-available/booked.conf && \
    sed -i 's,${APACHE_LOG_DIR},/var/log/apache2,g' /etc/apache2/sites-available/booked.conf && \
    a2ensite booked.conf

WORKDIR /var/www/booked

EXPOSE 80 443

CMD ["apache2-foreground"]
#ENTRYPOINT ["/bin/bash"]