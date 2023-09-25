# Use uma imagem oficial do PHP 8.2 com suporte ao PostgreSQL
FROM php:8.2

# Atualize e instale as dependências
RUN apt-get update -y && apt-get install -y libpq-dev libmcrypt-dev git unzip

# Instale o Composer globalmente
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

# Habilita as extensões PDO e PDO PostgreSQL
RUN docker-php-ext-install pdo pdo_pgsql

# Configurações adicionais do PHP (opcional, pode ser personalizado conforme necessário)
RUN echo "memory_limit=-1" > /usr/local/etc/php/conf.d/memory-limit.ini

# Define o diretório de trabalho como /app
WORKDIR /app

# Copie os arquivos do seu projeto Laravel para o contêiner
COPY . /app

# Instale as dependências do Composer
RUN composer install

# Exponha a porta 8000 (ou a porta que você deseja usar para o servidor Laravel)
EXPOSE 8000

# Comando para iniciar o servidor Laravel
CMD php artisan serve --host=0.0.0.0 --port=8000