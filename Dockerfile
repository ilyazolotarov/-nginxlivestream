FROM alpine:latest
ENV NGINX_VERSION nginx-1.15.9
RUN apk --update add git openssl-dev pcre-dev zlib-dev wget build-base && \
    git clone https://github.com/arut/nginx-ts-module.git && \
    mkdir -p /tmp/src && \
    cd /tmp/src && \
    wget http://nginx.org/download/${NGINX_VERSION}.tar.gz && \
    tar -zxvf ${NGINX_VERSION}.tar.gz && \
    cd /tmp/src/${NGINX_VERSION} && \
    ./configure \
        --with-http_ssl_module \
        --with-http_gzip_static_module \
        --prefix=/etc/nginx \
        --http-log-path=/var/log/nginx/access.log \
        --error-log-path=/var/log/nginx/error.log \
        --sbin-path=/usr/local/sbin/nginx \
        --prefix=/opt/nginx \
        --add-module=/nginx-ts-module \
        && \
    make && \
    make install && \
    apk del build-base && \
    rm -rf /tmp/src && \
    rm -rf /var/cache/apk/*

RUN  mkdir -p /var/media/hls && mkdir -p /var/media/dash

RUN ln -sf /dev/stdout /var/log/nginx/access.log
RUN ln -sf /dev/stderr /var/log/nginx/error.log

VOLUME ["/var/log/nginx"]

WORKDIR /etc/nginx
COPY nginx.conf nginx_cors.conf /etc/nginx/
EXPOSE 8080

CMD ["nginx", "-c", "/etc/nginx/nginx.conf", "-g", "daemon off;"]