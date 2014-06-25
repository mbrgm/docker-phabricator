FROM debian:jessie
MAINTAINER Marius Bergmann <marius@yeai.de>

# Install dependencies
RUN apt-get update && apt-get install -y \
    git-core \
    nginx \
    php5 php-apc php5-cli php5-curl php5-fpm php5-gd php5-mysql

RUN git clone git://github.com/phacility/libphutil.git /var/www/libphutil \
    && git clone git://github.com/phacility/arcanist.git /var/www/arcanist \
    && git clone git://github.com/phacility/phabricator.git /var/www/phabricator

ENV PHABRICATOR_DIR /var/www/phabricator

# Add config templates
ADD assets/config/ /app/config/

# Add init script
ADD assets/init /app/init
RUN chmod 755 /app/init

# Expose ports
EXPOSE 22
EXPOSE 80
EXPOSE 443

ENTRYPOINT ["/app/init"]
CMD ["app:start"]
