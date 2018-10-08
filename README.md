# WMCore-Docker

In order to build a docker image, one has to log in to one of the CMSSW maintained build machines, e.g.: cmsdocker05

## Some docker basics

Listing docker images available in the local host:
`docker images`

Building a new docker image using the Dockerfile in the current directory:
`docker build -t TAG_NAME .`

Listing all containers already executed in the local node (or still executing):
`docker ps --all`

Removing one of the containers listed above:
`docker rm NAME`

Removing an image created in the local node:
`docker image rm IMAGE_ID`

Running a container:
`docker run --rm -it IMAGE_ID`

## WMCore docker specifics
Docker images were - initially - splitted in two:
* a base WMCore image containing all the required seeds for slc7_amd64_gcc630, thus providing the base packages for the architecture bootstrap.
* a WMAgent image on top of the base WMCore image. This image follows almost the same deployment procedure as of a production agent, shipping CouchDB and MySQL within the same image.

Before building your own image, clone this repository
```
git clone https://github.com/amaltaro/WMCore-Docker.git && cd wmcore_base
```

then you can run a command like the one below in order to (re)build the WMCore base image:
```
docker build -t gitlab-registry.cern.ch/cmsdocks/dmwm:wmcore_base_test .
```

once it finishes, it returns an image ID (or one can use the tag provided in the command line with the option `-t` in order to run a container for that image).

For building a WMAgent image, switch to the wmagent directory, `cd ../wmagent`, and run:
```
docker build -t gitlab-registry.cern.ch/cmsdocks/dmwm:wmagent_test .
```

These images are only available in the local node. If we want to make then accessible to others, we need to push
them to the docker hub (or gitlab), which is still under development.
