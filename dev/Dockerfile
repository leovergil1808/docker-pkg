# Ubuntu
FROM php:8.2.5-apache
WORKDIR /var/www/html

RUN apt-get update -y

# Mod Rewrite
RUN a2enmod rewrite

# Linux Library
RUN apt-get update -y && apt-get install -y \
    libicu-dev \
    libmariadb-dev \
    unzip zip \
    zlib1g-dev \
    libpng-dev \
    libjpeg-dev \
    libfreetype6-dev \
    libjpeg62-turbo-dev \
    libpng-dev 

# Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

# PHP Extension
RUN docker-php-ext-install gettext intl pdo_mysql gd mysqli

RUN docker-php-ext-configure gd --enable-gd --with-freetype --with-jpeg \
    && docker-php-ext-install -j$(nproc) gd

# Cài sudo để có thể thực thi các lệnh với quyền root
RUN apt-get install -y sudo

# Cài Git để quản lý mã nguồn
RUN apt-get -y install git

# Cài Unzip để giải nén các tệp tin
RUN apt-get -y install unzip

# Cài trình soạn thảo Vim
RUN apt-get -y install vim

#  Cài wget để tải các tệp tin từ Internet.
RUN apt-get install -y wget

# Cài node 16
RUN curl -fsSL https://deb.nodesource.com/setup_16.x | sudo -E bash -
RUN apt-get install -y nodejs

# Cài trình biên dịch scss
RUN npm install -g sass

# Khởi động module thiết lập ssl
RUN a2enmod ssl

# Cài đặt supervisor
RUN apt-get install -y supervisor

RUN mkdir /script
RUN chmod 0777 -R /script