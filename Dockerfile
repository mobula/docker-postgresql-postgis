# forked from
#   https://gist.github.com/jpetazzo/5494158
#   https://github.com/Kloadut/dokku-pg-dockerfiles
#   Based on fermuch's postgis
#   https://docs.docker.com/examples/postgresql_service/

FROM    ubuntu:trusty
MAINTAINER      mobula "mobula.diabolus@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

# prevent apt from starting postgres right after the installation
#RUN     echo "#!/bin/sh\nexit 101" > /usr/sbin/policy-rc.d; chmod +x /usr/sbin/policy-rc.d

RUN apt-get update
RUN locale-gen en_US.UTF-8 && update-locale
RUN LANG=en_US.UTF-8 apt-get -y install python-software-properties software-properties-common
RUN LANG=en_US.UTF-8 apt-get -y install postgresql-9.3-postgis-2.1 postgresql-client-9.3 postgresql-contrib-9.3 postgis postgresql-9.3-postgis-scripts

# Note: The official Debian and Ubuntu images automatically ``apt-get clean``
# after each ``apt-get``
#RUN rm -rf /var/lib/apt/lists/*
#RUN apt-get clean

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

# allow autostart again
#RUN     rm /usr/sbin/policy-rc.d

#ADD     . /usr/bin
#RUN     chmod +x /usr/bin/start_pgsql.sh
#RUN chmod +x /usr/bin/add_postgis.sh
RUN echo 'host all all 0.0.0.0/0 md5' >> /etc/postgresql/9.3/main/pg_hba.conf
RUN sed -i -e"s/var\/lib/opt/g" /etc/postgresql/9.3/main/postgresql.conf
