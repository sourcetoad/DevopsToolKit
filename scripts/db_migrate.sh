#!/bin/bash

# Variable Setup
NEWLINE=$'\n'

DB_BINARY_NAME=''
DB_PORT=''
DB_HOST='127.0.0.1'
DB_USER='root'
DB_PASS='root'
DB_EXPORT_FLAGS='--routines --column-statistics=0 --quick --hex-blob --single-transaction'
DB_IMPORT_FLAGS=''

# Determine DB
echo "Welcome to the SDIT DB Migrator (mysql/postgres) $NEWLINE"
read -rp "Select (mysql|postgres):" DBMODE
read -rp "Enter (FROM) port number:" DB_PORT
read -rp "Enter (FROM) database name: " DB_NAME
read -rp "Enter (TO) port number:" DB_TO_PORT
read -rp "Enter (TO) database name: " DB_TO_NAME

case $DBMODE in

  mysql|maria|mariadb)
    DB_BINARY_NAME='mysql'

    # Attempt to connect to DB (FROM and TO).
    if ! $DB_BINARY_NAME --host="${DB_HOST}" --user="${DB_USER}" --password="${DB_PASS}" --port="${DB_PORT}" -e "use ${DB_NAME}"; then
       echo "Database (FROM) could not be connected ($DB_NAME, $DB_PORT). Aborting...$NEWLINE"
       exit 1;
    fi

    if ! $DB_BINARY_NAME --host="${DB_HOST}" --user="${DB_USER}" --password="${DB_PASS}" --port="${DB_TO_PORT}" -e "use ${DB_TO_NAME}"; then
       echo "Database (TO) could not be connected ($DB_TO_NAME, $DB_TO_PORT). Aborting...$NEWLINE"
       exit 1;
    fi

    echo -n "Copying...! $NEWLINE"
    mysqldump $DB_EXPORT_FLAGS --user="${DB_USER}" --password="${DB_PASS}" --host="${DB_HOST}" --port="${DB_PORT}" "${DB_NAME}" | mysql $DB_IMPORT_FLAGS --user="${DB_USER}" --password="${DB_PASS}" --host="${DB_HOST}" --port="${DB_TO_PORT}" "${DB_TO_NAME}"
    echo -n "Copied...! $NEWLINE"
    ;;

  pg|postgres)
    echo -n "Postgres support is still in progress. Aborting...$NEWLINE"
    ;;

  *)
    echo -n "This selection is unknown. Aborting...$NEWLINE"
    exit 1;
esac

exit 0;
