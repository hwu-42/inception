#!/bin/bash
set -e

# Function to initialize the database with secrets
initialize_database() {
  if [ ! -d "/var/lib/mysql/mysql" ]; then
    echo "Initializing database..."

    # Initialize the MariaDB database
    mariadb-install-db --user=mysql --datadir=/var/lib/mysql --auth-root-authentication-method=normal
    echo "Database initialized."

    # Start MariaDB temporarily (no networking, for initialization)
    mysqld_safe --skip-networking --datadir=/var/lib/mysql &
    pid="$!"

    # Wait until MariaDB is ready
    until mariadb --protocol=socket --user=root -e "SELECT 1;" &>/dev/null; do
      echo "Waiting for MariaDB to be ready..."
      sleep 1
    done

    # Set root password from the secret file
    if [ -n "${MYSQL_ROOT_PASSWORD_FILE}" ]; then
      MYSQL_ROOT_PASSWORD=$(cat "${MYSQL_ROOT_PASSWORD_FILE}")
    fi
    if [ -n "${MYSQL_ROOT_PASSWORD}" ]; then
      echo "Setting root password..."
      mariadb --protocol=socket --user=root <<-EOSQL
        ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';
      EOSQL
    fi

    # Set database name from the secret file
    if [ -n "${MYSQL_DATABASE}" ]; then
      echo "Creating database ${MYSQL_DATABASE}..."
      mariadb --protocol=socket --user=root <<-EOSQL
        CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;
      EOSQL
    fi

    # Set user and password from the secrets
    if [ -n "${MYSQL_USER}" ] && [ -n "${MYSQL_PASSWORD}" ]; then
      echo "Creating user ${MYSQL_USER}..."
      mariadb --protocol=socket --user=root <<-EOSQL
        CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
        GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';
        FLUSH PRIVILEGES;
      EOSQL
    fi

    # Stop the temporary MariaDB process
    kill "$pid"
    wait "$pid"
  fi
}

# Call the database initialization
initialize_database

# Now execute the default entrypoint for MySQL (or any command passed)
exec "$@"
