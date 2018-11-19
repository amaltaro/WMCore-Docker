FROM gitlab-registry.cern.ch/cmsdocks/dmwm:wmcore_base_test

RUN echo "Adding the AFS cmst1:zh user"
RUN groupadd -g 1399 zh
RUN adduser -u 31961 -g 1399 cmst1

### Setup directory and files permissions
ENV USER=cmst1
ENV GROUP=1399
RUN install -o ${USER} -g ${GROUP} -d /data/srv
RUN chown root:${GROUP} /data/

ENV WDIR=/data
ADD install.sh $WDIR/install.sh
ADD run.sh $WDIR/run.sh
ADD proxy.sh $WDIR/proxy.sh
RUN chown -R 31961:1399 $WDIR

# switch the user and start the setup
USER ${USER}
WORKDIR ${WDIR}

# install
RUN $WDIR/install.sh

# run the service
CMD ["./run.sh"]
