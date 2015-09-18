FROM ubuntu:15.04

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
                  
CMD ["bash"]

MAINTAINER Jarkko Saltiola
