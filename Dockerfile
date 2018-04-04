# Dockerfile for Munki-Docker
# Hopefully a much smaller image than others out there

# Start from Debian because its smaller than Ubuntu but gets the job done.
FROM nginx

MAINTAINER Steve Küng (steve.kueng@gmail.com)

# Create dirs for Munki
RUN mkdir -p /munki_repo && \
	mkdir -p /etc/nginx/sites-enabled/

# Add Munki config files
COPY nginx.conf /etc/nginx/nginx.conf
COPY munki-repo.conf /etc/nginx/sites-enabled/

# Expose volumes
VOLUME ["/munki_repo"]

# Expose ports
EXPOSE 80 443