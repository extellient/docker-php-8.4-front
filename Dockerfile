FROM debian:bookworm-slim

RUN apt-get update && apt-get install -y wget gnupg2 libzip4 apt-transport-https lsb-release ca-certificates && \
    wget -O /etc/apt/trusted.gpg.d/php.gpg https://packages.sury.org/php/apt.gpg && \
    echo "deb https://packages.sury.org/php/ $(lsb_release -sc) main" > /etc/apt/sources.list.d/php.list && \
    apt-get update && apt-get install -y php8.4 php8.4-intl php8.4-gd php8.4-soap php8.4-apcu git curl \
    php8.4-cli php8.4-curl php8.4-pgsql php8.4-ldap php8.4-dom \
    php8.4-sqlite php8.4-mysql php8.4-zip php8.4-xml \
    php8.4-mbstring php8.4-dev make libmagickcore-6.q16-2-extra unzip \
    php8.4-redis php8.4-imagick php8.4-dev libsystemd-dev && \
    apt-get autoremove -y && apt-get autoclean && apt-get clean && \
    rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*

RUN phpenmod xml simplexml mbstring mysql ldap gd dom
# Install Composer
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer --version-2.9.5
# Install node npm
RUN curl -sL https://deb.nodesource.com/setup_24.x | bash - \
    && apt-get install -y nodejs