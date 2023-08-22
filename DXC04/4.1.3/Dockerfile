FROM ubuntu:22.04
RUN apt update
RUN apt-get install -y tzdata
RUN apt-get install -y apache2
RUN apt-get install -y net-tools
RUN apt-get install -y openssh-server
RUN apt-get install -y php php-gd php-mysqlnd php-xmlrpc
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xzvf latest.tar.gz
RUN mv /wordpress/* /var/www/html
RUN chown -R www-data:www-data /var/www/html
COPY index.html /var/www/html
RUN chmod 2775 /var/www/html
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_PID_FILE /var/run/apache2.pid
ENV APACHE_RUN_DIR /var/run/apache2
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
RUN mkdir -p ${APACHE_RUN_DIR}
CMD [ "/usr/sbin/apache2", "-D", "FOREGROUND" ]
