#!/bin/bash

PG_VERSION="9.3"
PG_PATH="/usr/lib/postgresql/$PG_VERSION/bin"

PG_DATA="/var/lib/postgresql/$PG_VERSION/main"
PG_CONF="/etc/postgresql/$PG_VERSION/main/postgresql.conf"
POSTGRES="$PG_PATH/postgres"
INITDB="$PG_PATH/initdb"

PGISVERSION="2.1"

if [[ ! -f /opt/postgresql/initialized ]]; then
    mkdir -p /opt/postgresql
    cp -a /var/lib/postgresql/* /opt/postgresql/
    chown -R postgres:postgres /opt/postgresql
    su postgres sh -c "$PG_PATH/postgres --single  -D  $PG_DATA  -c config_file=$PG_CONF" <<< "CREATE USER root WITH SUPERUSER PASSWORD '$1';"
    su postgres sh -c "$PG_PATH/postgres --single  -D  $PG_DATA  -c config_file=$PG_CONF" <<< "CREATE DATABASE db ENCODING 'UTF8' TEMPLATE template0;"
    touch /opt/postgresql/initialized
fi
su postgres sh -c "/usr/lib/postgresql/9.3/bin/postgres           -D  /var/lib/postgresql/9.3/main  -c config_file=/etc/postgresql/9.3/main/postgresql.conf  -c listen_addresses=*"

# for postgis need to add
# CREATE EXTENSION postgis

