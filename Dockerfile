FROM resin/rpi-raspbian:jessie

LABEL maintainer "T Koopman"

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        git \
        libssl-dev \
        libpam0g-dev \
        zlib1g-dev \
        dh-autoreconf \
        libssl1.0.0 \
        libpam0g \
        openssl \
        ssh && \
    git clone https://github.com/shellinabox/shellinabox.git && \
    cd shellinabox && \
    autoreconf -i && \
    ./configure && \
    make && \
    mv shellinaboxd /bin/ && \
    mkdir /etc/shellinabox && \
    mkdir /etc/shellinabox/styles && \
    mv shellinabox/*.css /etc/shellinabox/styles/ && \
    apt-get remove --purge --auto-remove \
        autoconf automake autopoint autotools-dev binutils bsdmainutils bzip2 cpp \
        cpp-4.9 debhelper dh-autoreconf dh-strip-nondeterminism dpkg-dev file gcc \
        gcc-4.9 gettext gettext-base git git-man groff-base intltool-debian \
        libarchive-zip-perl libasan1 libasprintf0c2 libatomic1 libcloog-isl4 \
        libcroco3 libcurl3-gnutls libdpkg-perl liberror-perl libexpat1 libffi6 \
        libfile-stripnondeterminism-perl libgcc-4.9-dev libgdbm3 libglib2.0-0 \
        libgmp10 libgnutls-deb0-28 libgomp1 libhogweed2 libidn11 libisl10 \
        libldap-2.4-2 libmagic1 libmpc3 libmpfr4 libnettle4 libp11-kit0 libpipeline1 \
        librtmp1 libsasl2-2 libsasl2-modules-db libsigsegv2 libssh2-1 libtasn1-6 \
        libtimedate-perl libtool libubsan0 libunistring0 libxml2 m4 make man-db \
        patch perl perl-modules po-debconf && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* /shellinabox

RUN groupadd -r siab && useradd -r -g siab siab

VOLUME ["/config"]

EXPOSE 4200

COPY start.sh /bin/start.sh
COPY shellinabox.conf /etc/shellinabox/shellinabox.conf
RUN chmod +x /bin/start.sh

CMD start.sh
