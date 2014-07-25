# forked from
#   https://gist.github.com/jpetazzo/5494158
#   https://github.com/Kloadut/dokku-pg-dockerfiles
#   Based on fermuch's postgis
#   https://docs.docker.com/examples/postgresql_service/

FROM            ubuntu:trusty
MAINTAINER      mobula "mobula.diabolus@gmail.com"


ENV PG_VERSION          9.3
ENV PGIS_VERSION        2.1
ENV PG_LANG             en_US.UTF-8

# Add the PostgreSQL PGP key to verify their Debian packages.
# It should be the same key as https://www.postgresql.org/media/keys/ACCC4CF8.asc
#RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys B97B0AFCAA1A47F044F244A07FCC7D46ACCC4CF8

# Add PostgreSQL's repository. It contains the most recent stable release
#     of PostgreSQL, ``9.3``.
#RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ precise-pgdg main" > /etc/apt/sources.list.d/pgdg.list


# prevent apt from starting postgres right after the installation
#RUN     echo "#!/bin/sh\nexit 101" > /usr/sbin/policy-rc.d; chmod +x /usr/sbin/policy-rc.d


RUN apt-get update
RUN locale-gen --no-purge $PG_LANG
ENV LC_ALL en_US.UTF-8
RUN update-locale LANG=$PG_LANG
#RUN apt-get -y install python-software-properties software-properties-common
#RUN apt-get -y install libgdal1h libproj0 libgeos-c1 postgis postgresql-contrib-$PG_VERSION postgresql-$PG_VERSION-postgis-$PGIS_VERSION postgresql-$PG_VERSION-postgis-scripts
#RUN LANG=en_US.UTF-8 apt-get -y install postgresql-client-$PG_VERSION postgresql-contrib-$PG_VERSION
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install postgresql-9.3-postgis-2.1

# Note: The official Debian and Ubuntu images automatically ``apt-get clean``
# after each ``apt-get``

# Run the rest of the commands as the ``postgres`` user created by the ``postgres-9.3`` package when it was ``apt-get installed``
USER postgres

# Adjust PostgreSQL configuration so that remote connections to the
# database are possible.
RUN echo "host all  all    0.0.0.0/0  md5" >> /etc/postgresql/9.3/main/pg_hba.conf

# And add ``listen_addresses`` to ``/etc/postgresql/9.3/main/postgresql.conf``
RUN echo "listen_addresses='*'" >> /etc/postgresql/9.3/main/postgresql.conf

# Expose the PostgreSQL port
EXPOSE 5432

# Add VOLUMEs to allow backup of config, logs and databases
VOLUME  ["/etc/postgresql", "/var/log/postgresql", "/var/lib/postgresql"]

# Set the default command to run when starting the container
CMD ["/usr/lib/postgresql/9.3/bin/postgres", "-D", "/var/lib/postgresql/9.3/main", "-c", "config_file=/etc/postgresql/9.3/main/postgresql.conf"]

# Start PostgreSQL
# RUN    /etc/init.d/postgresql start

# allow autostart again
#RUN     rm /usr/sbin/policy-rc.d
