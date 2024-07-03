FROM debian:trixie
COPY ./supergfxctl/ /supergfxctl
WORKDIR /supergfxctl
ENV PKG_CONFIG_PATH /usr/lib/x86_64-linux-gnu/pkgconfig
RUN apt update \
    apt install git dpkg-dev build-essential -y \
    git clone https://gitlab.com/asus-linux/supergfxctl src \
    mv debian src \
    cd src && apt build-dep -y && dpkg-buildpackage -b -us -uc 

