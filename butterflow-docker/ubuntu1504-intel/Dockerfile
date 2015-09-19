FROM ubuntu:15.04

# File imitated from
# https://github.com/dockerfile/ubuntu/blob/master/Dockerfile

# TODO 
# [x] build butterflow
# [ ] get it to work after Intel OpenCL setup
# [ ] setup folder sharing from host
# [ ] cleanup dockerfile

RUN \
    apt-get update && \
    apt-get -y upgrade && \
    apt-get install -y git virtualenv python-dev ocl-icd-opencl-dev \
    libopencv-dev python-opencv ffmpeg
    
RUN cd /opt && \
    git clone https://github.com/dthpham/butterflow.git
    
RUN cd /opt/butterflow/ && \
    virtualenv venv && \
    
    echo "/usr/lib/python2.7/dist-packages" > venv/lib/python2.7/site-packages/cv.pth && \
    /bin/bash -c "source venv/bin/activate && \
    python setup.py develop" 
    
# TODO RUN apt-get -y install wget && \
#     mkdir /opt/amd-install && cd /opt/amd-install && \
#     wget http://www2.ati.com/drivers/linux/amd-catalyst-15.9-linux-installer-15.201.1151-x86.x86_64.zip
        

CMD ["bash"]

MAINTAINER Jarkko Saltiola
