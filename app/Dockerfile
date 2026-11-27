
FROM nginx:1.27-alpine

ARG BUILD_ID
ARG BUILD_VERSION
ARG BUILD_DATE
ARG BUILD_SHA

COPY . /usr/share/nginx/html

RUN sed -i \
    -e "s|__BUILD_ID__|${BUILD_ID}|g" \
    -e "s|__BUILD_VERSION__|${BUILD_VERSION}|g" \
    -e "s|__BUILD_DATE__|${BUILD_DATE}|g" \
    -e "s|__BUILD_SHA__|${BUILD_SHA}|g" \
    /usr/share/nginx/html/index.html

COPY nginx.conf /etc/nginx/conf.d/default.conf