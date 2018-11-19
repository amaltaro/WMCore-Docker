#!/bin/bash

### To run this container, you can use
# docker run --rm -t -d gitlab-registry.cern.ch/cmsdocks/dmwm:wmagent_couch
### then to attach/ssh to it
# docker exec -it CONTAINER_ID /bin/bash
###

# overwrite proxy file with one from secrets
if [ -f /etc/secrets/proxy ]; then
    mkdir -p /data/srv/state/couchdb/proxy
    /bin/cp -f /etc/secrets/proxy /data/srv/state/couchdb/proxy/proxy.cert
fi

# overwrite header-auth key file with one from secrets
if [ -f /etc/secrets/hmac ]; then
    sudo rm /data/srv/current/auth/wmcore-auth/header-auth-key
    cp /etc/secrets/hmac /data/srv/current/auth/wmcore-auth/header-auth-key
    # generate new hmac key for couch
    chmod u+w /data/srv/current/auth/couchdb/hmackey.ini
    perl -e 'undef $/; print "[couch_cms_auth]\n"; print "hmac_secret = ", unpack("h*", <STDIN>), "\n"' < /etc/secrets/hmac > /data/srv/current/auth/couchdb/hmackey.ini
    chmod ug+rx,o-rwx /data/srv/current/auth/couchdb/hmackey.ini
fi

# adjust configuration for k8s
# VK temp fix: so far backend auth fails, but we'll trust our host auth
hostname=`hostname -f`
hostip=`/bin/host $hostname | awk '/has address/ { print $4 }'`
echo "Container hostname: $hostname"
echo "Container ip address: $hostip"

### FIXME: applying some couch tweaks, but there are plenty more. Figure out how to do that
sed -i "/\[httpd\]/a port = 5984" /data/srv/current/config/couchdb/local.ini
#sed -i "s+bind_address = 0.0.0.0+bind_address = 127.0.0.1+" /data/srv/current/config/couchdb/local.ini  # couch does not start with this line
sed -i "/couch_cms_auth/d" /data/srv/current/config/couchdb/local.ini
sed -i "/allowed_hosts/d" /data/srv/current/config/couchdb/local.ini
sed -i "/allow_backend_passthrough/d" /data/srv/current/config/couchdb/local.ini
sed -i "/validate_hmac/d" /data/srv/current/config/couchdb/local.ini

echo -e "\nAMR final local.ini config:"
cat /data/srv/current/config/couchdb/local.ini

# get proxy
/data/proxy.sh $USER
sleep 2

# start the service
echo -e "\nStarting couch..."
/data/srv/current/config/couchdb/manage start 'I did read documentation'
/data/srv/current/config/couchdb/manage status 'I did read documentation'

# start cron daemon
#sudo /usr/sbin/crond -n    # sudo: command not found

tail -f /dev/null  # keep it running forever
