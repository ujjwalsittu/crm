FROM frappe/bench:latest

LABEL maintainer="usittu@gmail.com"

# Install dependencies
USER root
RUN apt-get update && \
    apt-get install -y mariadb-server redis-server supervisor && \
    apt-get clean

# Set environment
ENV MYSQL_ROOT_PASSWORD=04c35bbd2989ca734e665395f9c727a0
ENV SHELL=/bin/bash

# Copy init and supervisor config
COPY init.sh /workspace/init.sh
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Create MySQL data dir
RUN mkdir -p /var/lib/mysql /var/log/supervisor && \
    chown -R mysql:mysql /var/lib/mysql

# Default working dir for Frappe
WORKDIR /home/frappe

# Expose ports
EXPOSE 8000 9000 3306 6379

CMD ["/usr/bin/supervisord", "-n"]
