#!/usr/bin/env bash
export TNS_ADMIN=/opt/oracle/network/admin
source /usr/local/rvm/scripts/rvm
export GEM_HOME
export GEM_PATH
export PATH
/usr/sbin/apachectl -DFOREGROUND
