#!/bin/bash

# Variable Setup
NEWLINE=$'\n'

DB_BINARY_NAME=''
DB_PORT=''
DB_HOST='127.0.0.1'
DB_USER='root'
DB_PASS='root'
DB_EXPORT_FLAGS='--routines --quick --hex-blob --single-transaction'
DB_IMPORT_FLAGS=''

# Determine DB
echo "Welcome to the SDIT DB Migrator (mysql/postgres) $NEWLINE"
read -rp "Select (mysql|postgres):" DB_MODE
read -rp "Enter (FROM) port number:" DB_PORT
read -rp "Enter (FROM) database name: " DB_NAME
read -rp "Enter (TO) port number:" DB_TO_PORT
read -rp "Enter (TO) database name: " DB_TO_NAME

# Given the output of "docker ps" and a port, can find a matching line of:
# 6eabb950ac3f   mariadb:10.2  "docker-entrypoint.s…" 2 weeks ago Up 30 hours 0.0.0.0:33102->3306/tcp sourcetoad_mariadb102
# and extract "sourcetoad_mariadb102"
<<<<<<< HEAD
CONTAINER_NAME_FROM=$(docker ps | grep "$DB_PORT" | rev | cut -d" " -f1 | rev)
CONTAINER_NAME_TO=$(docker ps | grep "$DB_TO_PORT" | rev | cut -d" " -f1 | rev)
=======
CONTAINER_NAME_FROM=$(docker ps | grep $DB_PORT | rev | cut -d" " -f1 | rev)
CONTAINER_NAME_TO=$(docker ps | grep $DB_TO_PORT | rev | cut -d" " -f1 | rev)

>>>>>>> 96402b5b32565b6d9b4533c92d2607dce1db81b1

case $DB_MODE in
    mysql|maria|mariadb)
        DB_BINARY_NAME='mysql'

        # Attempt to connect to DB (FROM and TO).
        if ! $DB_BINARY_NAME --host="${DB_HOST}" --user="${DB_USER}" --password="${DB_PASS}" --port="${DB_PORT}" -e "use ${DB_NAME}"; then
            echo "Database (FROM) could not be connected ($DB_NAME, $DB_PORT). Aborting...$NEWLINE"
            exit 1
        fi

        if ! $DB_BINARY_NAME --host="${DB_HOST}" --user="${DB_USER}" --password="${DB_PASS}" --port="${DB_TO_PORT}" -e "use ${DB_TO_NAME}"; then
            echo "Database (TO) could not be connected ($DB_TO_NAME, $DB_TO_PORT). Aborting...$NEWLINE"
            exit 1
        fi

        echo -n "Copying...! $NEWLINE"
<<<<<<< HEAD
        # shellcheck disable=SC2086
=======
>>>>>>> 96402b5b32565b6d9b4533c92d2607dce1db81b1
        docker exec -i "$CONTAINER_NAME_FROM" mysqldump $DB_EXPORT_FLAGS --user="${DB_USER}" --password="${DB_PASS}" --port="${DB_PORT}" --databases "${DB_NAME}" | docker exec -i "$CONTAINER_NAME_TO" mysql --user="${DB_USER}" --password="${DB_PASS}" --port="${DB_TO_PORT}" "${DB_TO_NAME}"
        echo -n "Copied...! $NEWLINE"
    ;;

    pg | postgres)
        echo -n "Postgres support is still in progress. Aborting...$NEWLINE"
    ;;

    *)
        echo -n "This selection is unknown. Aborting...$NEWLINE"
        exit 1
    ;;
esac

exit 0
