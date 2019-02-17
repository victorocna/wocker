#!/bin/bash

# Remove previous versions
if test "$1" = "--clean"
then
  rm -rf wordpress && mkdir wordpress
  ./destroy.sh >/dev/null
fi

# Use env-example if no environment file is provided
if [ ! -f ./.env ]
then
  echo "No environment file provided. Using defaults"
  source ./env-example.txt
else
  source ./.env
fi

# Create empty dump.sql file if none provided
if [ ! -f ./dump.sql ]
then
  echo "No SQL file provided. Using defaults"
  touch wordpress/dump.sql
else
  # Migrate SQL: replace live website URL with local URL
  # Fun tip: to check if this command was successful, count the results like so
  # grep -o "localhost:8080" wordpress/dump.sql | wc -l
  sed -e "s|$LIVE_URL|$LOCAL_URL|g" dump.sql > wordpress/dump.sql
fi

# Unzip the "wp-content" archive if exists
if [ -f ./wp-content.zip ]
then
  echo "Expanding the wp-content archive"
  unzip -qu wp-content.zip -d wordpress
fi

# Create Wordpress config
cd wordpress && touch docker-compose.yml
cat > docker-compose.yml <<EOL
version: "2"
services:
  db:
    image: ${DB_IMAGE}
    restart: always
    volumes:
      - ./dump.sql:/docker-entrypoint-initdb.d/dump.sql
    ports:
      - "3306:3306"
    environment:
      MYSQL_DATABASE: ${DB_NAME}
      MYSQL_USER: ${DB_USER}
      MYSQL_ROOT_PASSWORD: ${DB_PASS}
  wordpress:
    image: ${WP_IMAGE}
    restart: always
    volumes:
      - ./:/var/www/html
      - ./wp-content/:/var/www/html/wp-content
    ports:
      - "8080:80"
    links:
      - db:mysql
    environment:
      WORDPRESS_DB_HOST: ${DB_HOST}
      WORDPRESS_DB_NAME: ${DB_NAME}
      WORDPRESS_DB_USER: ${DB_USER}
      WORDPRESS_DB_PASSWORD: ${DB_PASS}
  phpmyadmin:
    image: phpmyadmin/phpmyadmin
    environment:
      MYSQL_ROOT_PASSWORD: ${DB_PASS}
    ports:
      - 22222:80

volumes:
  mysql: {}

EOL

echo Using $DB_IMAGE as MySQL container
echo Using $WP_IMAGE as Wordpress container

# Fire up docker containers
# Visit http://localhost:8080 for sanity check
echo -e "\nStarting your local development environment. Enjoy!\n"
docker-compose up -d
