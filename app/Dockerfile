FROM nginx:1.27-alpine

ARG BUILD_ID=local ARG BUILD_VERSION=dev ARG BUILD_DATE=unknown

COPY . /usr/share/nginx/html

COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 8080