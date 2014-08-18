PostgreSQL 9.3 / Postgis 2.1 for Docker
=======================================

A [Docker](http://www.docker.com) configuration for **postgresql** with **postgis** support.

Based on Docker [official Postgres image](https://registry.hub.docker.com/_/postgres/) with the following differences:
- [x] adding **postgis-2.1**
- [ ] using _Ubuntu 14.04 trusty_ instead of _Debian Wheezy_ as base image,

**Note:** As for the [official Postgres image](https://registry.hub.docker.com/_/postgres/), the installation script creates a default database (`postgres`) with user `postgres` (no password). We may still create an application specific user and database.


Installation
------------
```
docker build -t mobula/postgresql github.com/mobula/docker-postgresql-postgis
```

How to use this image
---------------------

#### start a postgres instance

```
docker run --name some-postgres -d mobula/postgresql
```

This image includes `EXPOSE 5432` (the postgres port), so standard container linking will make it automatically available to the linked containers. The default postgres user and database are created in the entrypoint with initdb.

The `postgres` database is a default database meant for use by users, utilities and third party applications. [postgresql.org/docs](http://www.postgresql.org/docs/9.3/interactive/app-initdb.html)

#### connect to it from an application
```
docker run --name some-app --link some-postgres:postgres -d application-that-uses-postgres
```
#### … or via `psql`
```
docker run -it --link some-postgres:postgres --rm mobula/postgresql sh -c 'exec psql -h "$POSTGRES_PORT_5432_TCP_ADDR" -p "$POSTGRES_PORT_5432_TCP_PORT" -U postgres'
```

Environment variables
---------------------
The following environment variables are exposed:

```bash
HOSTNAME=97d51c4b353e
LANG=en_US.utf8

PG_VERSION=9.3.5-1.pgdg70+1
PG_MAJOR=9.3
PGDATA=/var/lib/postgresql/data

POSTGRES_NAME=/naughty_morse/postgres
POSTGRES_PORT=tcp://172.17.0.4:5432
POSTGRES_PORT_5432_TCP_PROTO=tcp
POSTGRES_PORT_5432_TCP_ADDR=172.17.0.4
POSTGRES_PORT_5432_TCP_PORT=5432
POSTGRES_PORT_5432_TCP=tcp://172.17.0.4:5432

POSTGRES_ENV_LANG=en_US.utf8
POSTGRES_ENV_PG_MAJOR=9.3
POSTGRES_ENV_PG_VERSION=9.3.5-1.pgdg70+1
POSTGRES_ENV_PGDATA=/var/lib/postgresql/data
```


Enabling postGIS
----------------
In order to enable **postGIS**, connect to the selected database (by default: `postgres`) and run the following command:
```sql
CREATE EXTENSION postgis;
```
