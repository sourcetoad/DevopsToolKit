FROM php:8.1-fpm

# System dependencies needed
RUN apt-get update && apt-get install --no-install-recommends -y \
    git \
    vim \
    openssl \
    zip \
    libzip-dev \
    curl \
    wget \
    gnupg \
    apt-transport-https \
    lsb-release \
    libicu-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libicu-dev \
    libmagickwand-dev \
    libghc-postgresql-libpq-dev \
    libbz2-dev \
    libfontconfig \
    && apt-get -y autoremove \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

# PHP Extensions needed for Laravel
RUN docker-php-ext-install calendar zip intl pdo_mysql bcmath opcache pdo

# Per project extensions needed for specific project
RUN docker-php-ext-configure gd --with-freetype=/usr/include/ --with-jpeg=/usr/include/
RUN docker-php-ext-install gd
RUN docker-php-ext-install bz2

# Xdebug install (Allowing debugging for PHP)
RUN pecl install xdebug
RUN docker-php-ext-enable xdebug

# Copy the config/php.ini into the container
#COPY ./config/php.ini /usr/local/etc/php/

# Set the working directory to /code
WORKDIR /code

# Make sure we're installing what we think we're installing!
COPY --from=composer:2 /usr/bin/composer /usr/local/bin/composer

# Node: We should use another container for this, since we are mixing PHP and Node
RUN curl -sL https://deb.nodesource.com/setup_14.x | bash - \
    && apt-get install --no-install-recommends -y nodejs

# Yarn: Installing
RUN curl -o- -L https://yarnpkg.com/install.sh | bash

# Change settings for the fpm pool
RUN sed -i -e "s/pm.max_children\s*=\s*[0-9]*/pm.max_children = 30/g" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i -e "s/pm.max_spare_servers\s*=\s*[0-9]*/pm.max_spare_servers = 10/g" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i -e "s/;pm.max_requests\s*=\s*[0-9]*/pm.max_requests = 500/g" /usr/local/etc/php-fpm.d/www.conf
RUN sed -i -e "s/access.log/;access.log/g" /usr/local/etc/php-fpm.d/docker.conf

# Set ENV for yarn
ENV PATH "$PATH:/root/.yarn/bin"

# Expose PHP and execute php-fpm
EXPOSE 9000
CMD ["php-fpm"]
