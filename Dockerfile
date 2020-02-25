FROM ubuntu:latest AS build

ADD https://github.com/gohugoio/hugo/releases/download/v0.65.3/hugo_0.65.3_Linux-64bit.deb hugo.deb
RUN dpkg -i hugo.deb

RUN mkdir site
WORKDIR /site

COPY archetypes archetypes
COPY content content
COPY data data
COPY layouts layouts
COPY resources resources
COPY static static
COPY themes themes
COPY config.toml config.toml

RUN hugo -D

FROM nginx:alpine

COPY --from=build /site/public /usr/share/nginx/html/
COPY nginx.conf /etc/nginx/conf.d/default.conf

EXPOSE 80