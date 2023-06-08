FROM debian:bullseye

RUN apt-get update \
    && apt-get install -y ruby ruby-dev rubygems build-essential squashfs-tools rpm \
    && gem install fpm \
    && fpm --version
