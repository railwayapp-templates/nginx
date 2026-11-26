FROM nginx:alpine

ARG BUILD_ID=local
ARG BUILD_VERSION=dev
ARG BUILD_DATE=unknown

COPY . /usr/share/nginx/html

RUN sed -i \
    -e "s|__BUILD_ID__|${BUILD_ID}|g" \
    -e "s|__BUILD_VERSION__|${BUILD_VERSION}|g" \
    -e "s|__BUILD_DATE__|${BUILD_DATE}|g" \
    /usr/share/nginx/html/index.html

EXPOSE 80 
