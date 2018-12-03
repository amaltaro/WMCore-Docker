FROM gitlab-registry.cern.ch/cmsdocks/dmwm:wmcore_base_test

# Add the extra system stuff we need
#RUN echo "Updating the base system - 2017-06-16"
#RUN yum -y install cern-get-sso-cookie && yum clean all

# We need pip and virtualenv
RUN yum -y install python2-pip python-virtualenv

# WMAgent RPM dependencies
RUN yum -y install gcc openssl-devel libcurl-devel mariadb mariadb-devel jemalloc

# Condor Installation - we probaby should build this ourselves
RUN yum -y install condor

# Install CouchDB
COPY bintray-apache-couchdb-rpm.repo /etc/yum.repos.d/bintray-apache-couchdb-rpm.repo
RUN yum -y install couchdb

RUN echo "Adding the AFS cmst1:zh user"
RUN groupadd -g 1399 zh
RUN adduser -u 31961 -g 1399 cmst1

### Setup directory and files permissions
RUN install -o cmst1 -g 1399 -d /data/srv /data/admin /data/certs
RUN chown root:1399 /data/

COPY servicecert.pem servicekey.pem /data/certs/
RUN chown -R 31961:1399 /data/certs/

COPY WMAgent.secrets env.sh /data/admin/wmagent/
RUN chown -R 31961:1399 /data/admin/

COPY deploy-wmagent.sh /data/srv/
RUN chown -R 31961:1399 /data/srv/

# Switch user
USER cmst1

# Install Oracle
COPY oracle_install.sh /home/cmst1/oracle_install.sh
RUN sh /home/cmst1/oracle_install.sh
RUN rm -f /home/cmst1/oracle_install.sh

ENV ORACLE_HOME=/data/srv/depend/oracle

# setup a fake service certificate
RUN ls -l /data
#WORKDIR /data/certs
RUN ls -l /data/certs

# setup a default agent env and secrets
#WORKDIR /data/admin/wmagent

# Time to get dirty
WORKDIR /data/srv

# Install cms-bot and WMCore
RUN echo "Installing WMAgent"
#RUN sh deploy-wmagent.sh -w 1.1.15.patch5 -d HG1808g -t testbed-docker

# Set up the wmagent virtualenv
COPY pydistutils.cfg /home/cmst1/.pydistutils.cfg
RUN virtualenv wmagent
RUN /bin/bash -c "source wmagent/bin/activate; pip --no-cache-dir install wmagent; deactivate"
#RUN pip install wmagent
RUN echo "Installation completed!"

#Finished
ENTRYPOINT ["/bin/bash"]

