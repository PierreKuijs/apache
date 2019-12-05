# LICENSE UPL 1.0
#
# Copyright (c) 2014-2015 Oracle and/or its affiliates. All rights reserved.
#
# ORACLE DOCKERFILES PROJECT
# --------------------------
#
# Dockerfile template for Oracle Instant Client
#
# REQUIRED FILES TO BUILD THIS IMAGE
# ==================================
# 
# From http://www.oracle.com/technetwork/topics/linuxx86-64soft-092277.html
#  Download the following three RPMs:
#    - oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm
#    - oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm
#    - oracle-instantclient12.2-sqlplus-12.2.0.1.0-1.x86_64.rpm 
#
# HOW TO BUILD THIS IMAGE
# -----------------------
# Put all downloaded files in the same directory as this Dockerfile
# Run: 
#      $ docker build --pull -t oracle/instantclient:12.2.0.1 .
#
#
FROM oraclelinux:7-slim

ADD oracle-instantclient*.rpm /tmp/
ADD HTML.py-0.04 /tmp/HTML.py-0.04

RUN  yum -y install /tmp/oracle-instantclient*.rpm && \
     rm -rf /var/cache/yum && \
     rm -f /tmp/oracle-instantclient*.rpm && \
     echo /usr/lib/oracle/12.2/client64/lib > /etc/ld.so.conf.d/oracle-instantclient12.2.conf && \
     ldconfig

ENV PATH=$PATH:/usr/lib/oracle/12.2/client64/bin

RUN yum install -y which && \
  yum install -y httpd 

ADD rvm /usr/local/rvm
# ADD install_gems.sh .
# RUN ./install_gems.sh

#  gem install ruby-oci8 && \
#  gem install thamble

## RUN yum groupinstall -y 'Development Tools'
## RUN yum install -y ruby && \
##   yum-config-manager --enable ol7_optional_latest && \
##   yum install -y ruby-devel && \
##   gem install ruby-oci8
## 
RUN yum install -y python3 && \
  pip3 install cx-Oracle && \
  cd /tmp/HTML.py-0.04 && \
  python3 setup.py install

ENV TNS_ADMIN=/opt/oracle/network/admin
ENV GEM_HOME=/usr/local/rvm/gems/ruby-2.6.3
ENV GEM_PATH=/usr/local/rvm/gems/ruby-2.6.3:/usr/local/rvm/gems/ruby-2.6.3@global
ENV NLS_LANG=American_America.UTF8
ENV PYTHONIOENCODING=UTF-8

ADD start.sh .
RUN chmod 775 start.sh

EXPOSE 80

#ENTRYPOINT ["/usr/sbin/httpd", "-D", "FOREGROUND"]
#ENTRYPOINT ["/usr/sbin/apachectl", "-D", "FOREGROUND"]
ENTRYPOINT ["./start.sh"]
