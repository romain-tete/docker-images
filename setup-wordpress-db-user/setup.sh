#!/bin/sh

root_password_file="/run/secrets/root_password"
user_password_file="/run/secrets/user_password"


db_name=$DB_NAME
db_username=$DB_NAME
db_host=$DB_HOST
read db_password < $user_password_file
read root_password < $root_password_file

until mysql --host="$db_host" --user="root" --password="$root_password" -e '\q'; do
  echo "MySQL is unavailable - sleeping"
  sleep 3
done

$(mysql \
      --user="root" \
      --password="$root_password" \
      --host="$db_host" \
      -e "\
      CREATE DATABASE IF NOT EXISTS $db_name; \
      CREATE USER IF NOT EXISTS '$db_username'@'%' IDENTIFIED BY '$db_password'; \
      ALTER USER '$db_username'@'%' IDENTIFIED BY '$db_password'; \
      GRANT ALL PRIVILEGES ON $db_name.* TO '$db_username'@'%';"
)