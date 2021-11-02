FROM php:7.0-fpm

# System dependencies needed
RUN apt-get update && apt-get install -y \
    git \
    vim \
    openssl \
    curl \
    wget \
    libicu-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libmcrypt-dev \
    libpng12-dev \
    libicu-dev \
    libmagickwand-dev \
    libghc-postgresql-libpq-dev \
    libbz2-dev \
    libfontconfig \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# PHP Extensions needed for yii2
RUN docker-php-ext-install calendar zip mcrypt intl mbstring pdo_mysql bcmath opcache pdo pdo_pgsql

# Per project extensions needed for specific project
RUN docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/
RUN docker-php-ext-install gd
RUN docker-php-ext-install bz2
RUN docker-php-ext-install exif

# Xdebug install (Allowing debugging for PHP)
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug

# Copy the config/php.ini into the container
COPY ./config/php.ini /usr/local/etc/php/

# Set the working directory to /code
WORKDIR /code

# Change settings for the fpm pool
RUN sed -i -e "s/pm.max_children\s*=\s*[0-9]*/pm.max_children = 30/g" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i -e "s/pm.max_spare_servers\s*=\s*[0-9]*/pm.max_spare_servers = 10/g" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i -e "s/;pm.max_requests\s*=\s*[0-9]*/pm.max_requests = 500/g" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i -e "s/access.log/;access.log/g" /usr/local/etc/php-fpm.d/docker.conf
RUN sed -i -e "s/^error_log.*/error_log = \/proc\/self\/fd\/2/" /usr/local/etc/php-fpm.d/www.conf

# Expose PHP and execute php-fpm
EXPOSE 9000
CMD ["php-fpm"]
