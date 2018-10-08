FROM cern/cc7-base:latest

# Required seeds for bootstrapping slc7_amd64_gcc630 (several of them are already available in the cc7_base image)
RUN yum -y update && yum -y install bash bzip2 bzip2-libs compat-libstdc++-33 coreutils e2fsprogs e2fsprogs-libs file file-libs \
                                    fontconfig freetype glibc krb5-libs libICE libSM libX11 libX11-devel libXcursor libXext libXext-devel \
                                    libXft libXft-devel libXi libXinerama libXmu libXpm libXpm-devel libXrandr libXrender libcom_err \
                                    libidn mesa-libGL mesa-libGLU mesa-libGLU-devel ncurses ncurses-libs nspr nss nss-util openssl perl \
                                    perl-Carp perl-Data-Dumper perl-Digest-MD5 perl-Encode perl-Env perl-Exporter perl-ExtUtils-Embed perl-File-Path \
                                    perl-File-Temp perl-Getopt-Long perl-PathTools perl-Socket perl-Storable perl-Switch perl-Test-Harness \
                                    perl-Text-ParseWords perl-Thread-Queue perl-Time-Local perl-constant perl-libs popt readline readline tcl \
                                    tcsh tk zlib zsh && yum clean all

# Other utilitarian/necessary packages for WMAgent deployment
RUN yum -y update && yum -y install which wget unzip cronie yum-plugin-priorities tar rsync git voms-clients-cpp && yum clean all

# And a list from Alan:
RUN yum -y update && yum -y install libaio && yum clean all

# Try more stuff from other CMS images
RUN yum update -y && yum install -y krb5-devel readline-devel && yum clean all

#RUN yum update -y && yum install -y HEP_OSlibs && yum clean all  ### this seems to add around 330MB to the image size

### Interesting stuff, but keeping it out for now to make a tiny image
#RUN yum update -y && yum install -y finger screen krb5-devel subversion telnet readline-devel \
#                                    glibc-devel.x86_64 mesa-libGL-devel.x86_64 mesa-libGLU-devel.x86_64 && yum clean all

# Finally, clean the yum cache to release some space
RUN rm -rf /var/cache/yum

#RUN wget -O HEP.rpm http://linuxsoft.cern.ch/wlcg/sl6/x86_64/HEP_OSlibs_SL6-1.0.16-0.el6.x86_64.rpm && wget -O OSG.rpm https://repo.grid.iu.edu/osg/3.3/osg-3.3-el6-release-latest.rpm && yum -y install HEP.rpm OSG.rpm && yum clean all
#RUN yum -y install HEP_OSlibs_CC7 osg-ca-certs vo-client && yum clean all
CMD ['/bin/sh']
