FROM gitlab-registry.cern.ch/cmsdocks/dmwm:wmcore_base_test

# Add the extra system stuff we need
#RUN echo "Updating the base system - 2017-06-16"
#RUN yum -y install cern-get-sso-cookie && yum clean all

# Add the common cmst1:zh (AFS) user
RUN groupadd -g 1399 zh
#RUN adduser -u 31961 -g 1399 cmst1 && install -d /opt && install -d -o cmsbuild /opt/cms /build
RUN adduser -u 31961 -g 1399 cmst1
RUN install -d -o cmst1 -g 1399 /data/srv

# Switch user
USER cmst1

WORKDIR /data/srv
#COPY --chown=cmst1:zh /data/srv/ /data/srv/
#COPY  /data/srv/
RUN mkdir certs

# Remove this when stable
COPY installWMCore.sh /data/srv/

# Install cms-bot and WMCore
RUN echo "Installing WMCore"
RUN sh installWMCore.sh

#Finished
ENTRYPOINT ["/bin/bash"]

