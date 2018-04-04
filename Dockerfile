# Dockerfile for Munki-Docker
# Hopefully a much smaller image than others out there

# Start from Debian because its smaller than Ubuntu but gets the job done.
FROM debian:8-slim

MAINTAINER Steve Küng (steve.kueng@gmail.com)

# Add the packages we need from apt then remove the cached list saving some disk space
RUN apt-get update && \ 
	apt-get install -y nginx && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/*

# Create dirs for Munki
RUN mkdir -p /munki_repo && \
	mkdir -p /etc/nginx/sites-enabled/

# Add Munki config files
ADD nginx.conf /etc/nginx/nginx.conf
ADD munki-repo.conf /etc/nginx/sites-enabled/

# Expose volumes
VOLUME ["/munki_repo"]

# Expose ports
EXPOSE 80 443