# Use an official Ubuntu as a base image
FROM ubuntu:22.04

# Set environment variables
ENV NGINX_VERSION=1.24.0

# Install dependencies, download and compile Nginx, and clean up
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
        gcc \
        libc-dev \
        make \
        wget \
        libpcre3-dev \
        zlib1g-dev \
        libssl-dev \
        libxml2-dev \
        libxslt1-dev \
        libgd-dev \
        libgeoip-dev \
        libperl-dev \
    && rm -rf /var/lib/apt/lists/* \
    && wget -O nginx.tar.gz "https://nginx.org/download/nginx-1.24.0.tar.gz
    " \
    && tar -zxC /usr/src -f nginx.tar.gz \
    && rm nginx.tar.gz \
    && cd /usr/src/nginx-${NGINX_VERSION} \
    && ./configure \
        --prefix=/usr/share/nginx \
        --sbin-path=/usr/sbin/nginx \
        --modules-path=/usr/lib/nginx/modules \
        --conf-path=/etc/nginx/nginx.conf \
        --error-log-path=/var/log/nginx/error.log \
        --http-log-path=/var/log/nginx/access.log \
        --pid-path=/var/run/nginx.pid \
        --lock-path=/var/run/nginx.lock \
        --http-client-body-temp-path=/var/cache/nginx/client_temp \
        --http-proxy-temp-path=/var/cache/nginx/proxy_temp \
        --http-fastcgi-temp-path=/var/cache/nginx/fastcgi_temp \
        --http-uwsgi-temp-path=/var/cache/nginx/uwsgi_temp \
        --http-scgi-temp-path=/var/cache/nginx/scgi_temp \
        --user=nginx \
        --group=nginx \
        --with-compat \
        --with-file-aio \
        --with-threads \
        --with-http_ssl_module \
        --with-stream \
        --with-http_geoip_module=dynamic \
        --with-http_image_filter_module=dynamic \
        --with-http_xslt_module=dynamic \
        --with-http_perl_module=dynamic \
        --with-mail=dynamic \
        --with-mail_ssl_module \
    && make \
    && make install \
    && apt-get purge -y --auto-remove gcc libc-dev make wget \
        libpcre3-dev zlib1g-dev libssl-dev libxml2-dev libxslt1-dev \
        libgd-dev libgeoip-dev libperl-dev \
    && apt-get clean \
    && rm -rf /usr/src/nginx-${NGINX_VERSION}

# Forward request logs to Docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

# Expose ports
EXPOSE 8080
EXPOSE 8443

# Health check
HEALTHCHECK --interval=30s --timeout=5s \
    CMD curl -sSf http://localhost:8080/ || exit 1

# Copy custom nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Define the default command to run when the container starts
CMD ["nginx", "-g", "daemon off;"]

# Metadata
LABEL maintainer="Venkatesh <venky.v1b7@gmail.com>" \
      version="1.24.0" \
      description="Dockerfile for Nginx ${NGINX_VERSION}"





##Note: significant points
    #1. Base image - ubuntu 
    #2. Nginx Version - Legacy version:1.24.0
    #3. Exposed ports - 8080,8443(http and https)
    #4. Replace local host with actual application url
    #5. Make sure "nginx.config" file available in the mentioned path
    
