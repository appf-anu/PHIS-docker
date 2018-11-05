FROM php:7.1-apache
RUN apt-get update && apt-get install -y libxml2 libxml2-dev zlib1g-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libpng-dev 
RUN docker-php-ext-install xml
RUN docker-php-ext-install zip
RUN docker-php-ext-install gd
