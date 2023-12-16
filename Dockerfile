FROM ghcr.io/linuxserver/baseimage-ubuntu:jammy

# environment settings
ARG DEBIAN_FRONTEND="noninteractive"
ENV HOME="/config"

RUN \ 
    echo "**** install runtime dependencies ****" && \
    apt-get update && \
    apt-get install -y \
        vim \
        imagemagick \
        apache2 \
        subversion \
        ghostscript \
        antiword \
        poppler-utils \
        libimage-exiftool-perl \
        cron \
        postfix \
        wget \
        php \
        php-apcu \
        php-curl \
        php-dev \
        php-gd \
        php-intl \
        php-mysqlnd \
        php-mbstring \
        php-zip \
        libapache2-mod-php \
        ffmpeg \
        libopencv-dev \
        python3-opencv \
        python3 \
        python3-pip
RUN \
    echo "**** clean up ****" && \
    apt-get clean
RUN \
    sed -i -e "s/upload_max_filesize\s*=\s*2M/upload_max_filesize = 10G/g" /etc/php/8.1/apache2/php.ini && \
    sed -i -e "s/post_max_size\s*=\s*8M/post_max_size = 10G/g" /etc/php/8.1/apache2/php.ini && \
    sed -i -e "s/max_execution_time\s*=\s*30/max_execution_time = 10000/g" /etc/php/8.1/apache2/php.ini && \
    sed -i -e "s/memory_limit\s*=\s*128M/memory_limit = 4G/g" /etc/php/8.1/apache2/php.ini && \
    printf '<Directory /var/www/>\n\
    \tOptions FollowSymLinks\n\
    </Directory>\n'\
    >> /etc/apache2/sites-enabled/000-default.conf
RUN \
    rm -rf /var/www/html/index.html && \
    svn co -q https://svn.resourcespace.com/svn/rs/releases/10.2 /var/www/html && \
    mkdir /var/www/html/filestore && \
    chmod 777 /var/www/html/filestore && \
    chmod -R 777 /var/www/html/include/

COPY /root /
VOLUME /config