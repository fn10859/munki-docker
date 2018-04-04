# Dockerfile for Munki-Docker
# Hopefully a much smaller image than others out there

# Start from Debian because its smaller than Ubuntu but gets the job done.
FROM debian:8-slim

MAINTAINER Steve Küng (steve.kueng@gmail.com)

# Add the packages we need from apt then remove the cached list saving some disk space
RUN apt-key adv --keyserver pgp.mit.edu --recv-keys 573BFD6B3D8FBC641079A6ABABF5BD827BD9BF62 && \
	echo "deb http://nginx.org/packages/mainline/debian/ jessie nginx" >> /etc/apt/sources.list && \
	apt-get update && \ 
	apt-get install -y nginx && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

# Create dirs for Munki
RUN mkdir -p /munki_repo && \
	mkdir -p /etc/nginx/sites-enabled/

# Add Munki config files
ADD nginx.conf /etc/nginx/nginx.conf
ADD munki-repo.conf /etc/nginx/sites-enabled/

# Add start up script
ADD start.sh /start.sh
RUN chmod +x /start.sh

# Set up logs
RUN ln -sf /dev/stdout /var/log/nginx/access.log && \
	ln -sf /dev/stderr /var/log/nginx/error.log

# Expose volumes
VOLUME ["/munki_repo"]

# Expose ports
EXPOSE 80 443

# Lets go!
CMD ["/start.sh"]