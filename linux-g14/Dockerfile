FROM debian:trixie
COPY ./linux-g14 /linux
WORKDIR /linux
RUN apt update \
    apt install aria2 debhelper dpkg-dev build-essential patch bc bison flex libssl-dev libelf-dev git perl python3 -y \
    aria2c https://github.com/NekoSekaiMoe/asus_linux_debian_test/releases/download/v1/linux-src.tar.xz \
    tar -xf linux-src.tar.xz \
    cd src && make asus_defconfig && bash patch.sh && make bindeb-pkg -j8 && rm -rf ../*dbg*.deb ../linux-src.tar.xz

