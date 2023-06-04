FROM mysql:8.0.28

# Tạo nơi lưu trữ dữ liệu và cấp quyền
RUN mkdir /data
RUN chmod 0777 data
RUN mkdir /data/mysql
RUN chmod 0777 data/mysql
RUN mkdir /data/log
RUN chmod 0777 data/log
RUN mkdir /data/log/mysql
RUN chmod 0777 data/log/mysql

RUN rm -f /var/lib/mysql/*
RUN rm -f /data/mysql/*

RUN chown -R mysql:mysql /data/mysql
RUN chown -R mysql:mysql /data/log/mysql

# timezone
RUN echo "USE mysql;" > /docker-entrypoint-initdb.d/timezones.sql &&  mysql_tzinfo_to_sql /usr/share/zoneinfo >> /docker-entrypoint-initdb.d/timezones.sql
