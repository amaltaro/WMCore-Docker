#!/bin/bash

ARCH=slc7_amd64_gcc630
VER=HG1811h
REPO="comp"
#PKGS="admin backend couchdb"
PKGS="couchdb"
SERVER=cmsrep.cern.ch

cd $WDIR
git clone git://github.com/dmwm/deployment.git cfg && cd cfg && git reset --hard $VER

# Deploy services
# we do not use InstallDev script directly since we want to capture the status of
# install step script. Therefore we call Deploy script and capture its status every step
cd $WDIR

# deploy services
for step in prep sw post; do
    $WDIR/cfg/Deploy -A $ARCH -R comp@$VER -r comp=$REPO -t $PKGS -w $SERVER -s $step $WDIR/srv "$PKGS"
    #$WDIR/cfg/Deploy -A $ARCH -R comp@$VER -r comp=$REPO -t $VER -w $SERVER -s $step $WDIR/srv "$PKGS"
    #$WDIR/cfg/Deploy -A $ARCH -R couchdb15@$VER -r comp=$REPO -t $VER -w $SERVER -s $step $WDIR/srv "$PKGS"
    if [ $? -ne 0 ]; then
        echo "AMR something bad happened in the step $step"
        cat $WDIR/srv/.deploy/*-$step.log
        exit 1
    fi
done

# add proxy generation via robot certificate
crontab -l > /tmp/mycron
echo "3 */3 * * * sudo /data/proxy.sh $USER 2>&1 1>& /dev/null" >> /tmp/mycron
crontab /tmp/mycron
rm /tmp/mycron
