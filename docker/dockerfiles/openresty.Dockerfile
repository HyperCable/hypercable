FROM openresty/openresty:alpine-fat

EXPOSE 8000
ENV REDIS_HOST redis
ENV REDIS_PORT 6379
RUN echo $REDIS_HOST
RUN /usr/local/openresty/luajit/bin/luarocks install lua-resty-reqargs
RUN /usr/local/openresty/luajit/bin/luarocks install lua-resty-jit-uuid
ADD nginx.conf /usr/local/openresty/nginx/conf/nginx.conf
#RUN echo 'hosts: files mdns4_minimal [NOTFOUND=return] dns mdns4' > /etc/nsswitch.conf