FROM mysql:5.7
COPY . .
#RUN apt-get update && apt-get install -y software-properties-common
#RUN add-apt-repository main && \
#    add-apt-repository universe && \
#    add-apt-repository restricted && \
#    add-apt-repository multiverse

#RUN apt-get install -y \
#    gcc \
#    g++ \
#    make \
#    mysql mysql-devel mysql-server \
#    pcre-devel \
#    zlib-devel \
#    expect


RUN apt-get dist-upgrade -y

# remove mariadb(?)
#RUN sudo sed -i 's/^.*mariadb.*$//g' /etc/apt/sources.list && \
#    sudo apt-get update

RUN apt-get update && apt-get install -y --force-yes \
    make \
    gcc \
    g++ \
    zlib1g-dev \
    libpcre3-dev \
    libmysqlclient-dev \
    expect \
    supervisor

# start mysql
RUN /etc/init.d/mysql start && \
    ./docker_scripts/mysql_secure.sh && \
    mysql -u root < /docker_scripts/create_user.sql && \
    cat /sql-files/*.sql | mysql --user=root -p ragnarok

RUN ./configure && make clean && make server

# set entrypoint to start the server
ENTRYPOINT [ "sh", "-c", "./athena-start start run" ]
