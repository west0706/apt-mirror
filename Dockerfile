FROM ubuntu:18.04

RUN apt-get update && apt-get install -y apt-mirror cron nginx vim

COPY mirror.list /etc/apt/mirror.list

COPY nginx/default /etc/nginx/sites-available/default

COPY ./crontab/apt-mirror /etc/cron.d

RUN ln -s /var/spool/apt-mirror/mirror/mirror.yongbok.net/mariadb /var/www/mariadb

ENTRYPOINT service nginx start && service cron start && crontab /etc/cron.d/* && /usr/bin/apt-mirror && tail -F /var/spool/apt-mirror/var/cron.log
