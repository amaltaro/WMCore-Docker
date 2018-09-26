#! /bin/sh

# Download the script to install everything
curl https://raw.githubusercontent.com/dmwm/WMCore/master/test/deploy/deploy_unittest.sh > deploy_unittest.sh
chmod +x deploy_unittest.sh
sh deploy_unittest.sh

echo "export PYTHONPATH=/data/srv/wmcore_unittest/WMCore/src/python:\$PYTHONPATH" >> ./env_unittest.sh
# Shut down services so the docker container doesn't have stale PID & socket files
source ./env_unittest.sh
$manage stop-services

