# forked from
#   https://gist.github.com/jpetazzo/5494158
#   https://github.com/Kloadut/dokku-pg-dockerfiles
#   Based on fermuch's postgis

FROM	ubuntu:trusty
MAINTAINER	mobula "mobula.diabolus@gmail.com"

# prevent apt from starting postgres right after the installation
RUN	echo "#!/bin/sh\nexit 101" > /usr/sbin/policy-rc.d; chmod +x /usr/sbin/policy-rc.d

RUN apt-get update
RUN locale-gen en_US.UTF-8 && update-locale LANG=en_US.UTF-8 apt-get install -y -q postgresql-9.3-postgis-2.1 postgresql-contrib-9.3 postgis postgresql-9.3-postgis-scripts
RUN rm -rf /var/lib/apt/lists/*
RUN apt-get clean

# allow autostart again
RUN	rm /usr/sbin/policy-rc.d

ADD	. /usr/bin
RUN	chmod +x /usr/bin/start_pgsql.sh
#RUN chmod +x /usr/bin/add_postgis.sh
RUN echo 'host all all 0.0.0.0/0 md5' >> /etc/postgresql/9.3/main/pg_hba.conf
RUN sed -i -e"s/var\/lib/opt/g" /etc/postgresql/9.3/main/postgresql.conf
