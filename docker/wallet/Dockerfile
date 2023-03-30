FROM ubuntu/apache2:latest
COPY ./index.html /var/www/html/index.html
COPY ./apple-app-site-association /var/www/html/apple-app-site-association
COPY ./000-default.conf /etc/apache2/sites-available/000-default.conf
RUN mkdir /var/www/html/.well-known
COPY .well-known/assetlinks.json /var/www/html/.well-known/assetlinks.json