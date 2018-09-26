FROM cern/cc7-base:latest
MAINTAINER Alan Malta Rodrigues alan.malta@cern.ch

RUN yum install -y cern-get-certificate fetch-crl voms-clients-cpp && yum clean all

### START: from Eric V. cms_grid flavor
#RUN yum -y update && yum -y install HEP_OSlibs cronie yum-plugin-priorities osg-ca-certs vo-client && yum clean all
RUN yum -y update && yum -y install which wget bzip2 git unzip finger screen rsync telnet vim \
                                    subversion tcsh zsh tcl tk openssl tar && yum clean all

# Try more stuff from cms images
RUN yum update -y && yum install -y HEP_OSlibs krb5-devel readline-devel glibc-devel.x86_64 \
                                    mesa-libGL-devel.x86_64 perl-ExtUtils-Embed compat-libstdc++-33 \
                                    libXmu libXcursor libXrandr e2fsprogs e2fsprogs-libs libXi \
                                    libXinerama && yum clean all

# And a list from Alan:
RUN yum -y update && yum -y install libaio libXft-devel libXpm-devel libXext-devel mesa-libGLU-devel perl-Switch perl-Env perl-Thread-Queue && yum clean all
### END: from Eric V.

CMD ['/bin/sh']
