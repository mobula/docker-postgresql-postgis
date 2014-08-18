docker-postgresql-postgis
=========================

A [Docker](http://www.docker.com) configuration for **postgresql** with **postgis** support.

Based on Docker [official Postgres image](https://registry.hub.docker.com/_/postgres/) with the following differences:
- [x] using _Ubuntu 14.04 trusty_ instead of _Debian Wheezy_ as base image,
- [x] adding **postgis-2.1**

**Note:** As with the [official Postgres image](https://registry.hub.docker.com/_/postgres/) you cannot configure its database name, username and password, but it does set up a user called `postgres` (no password) and a database called `postgres` which you can use instead.

PostgreSQL 9.3 for Docker.

    $ docker run -d -p 5432:5432 -e POSTGRESQL_USER=test -e POSTGRESQL_PASS=oe9jaacZLbR9pN -e POSTGRESQL_DB=test orchardup/postgresql
    da809981545f
    $ psql -h localhost -U test test
    Password for user test:
    psql (9.3.2, server 9.3.4)
    SSL connection (cipher: DHE-RSA-AES256-SHA, bits: 256)
    Type "help" for help.

    test=#

(Example assumes PostgreSQL client is installed on Docker host.)


Installation
------------
```
docker build -t mobula/postgresql github.com/mobula/docker-postgresql-postgis
```

Environment variables
---------------------
 - PG_MAJOR 9.3
 - PG_VERSION 9.3.5-1.pgdg70+1
 - PGIS_MAJOR 2.1
 - PGDATA /var/lib/postgres/data

