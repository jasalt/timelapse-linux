# Dockerfile for butterflow motion interpolation tool.
# Butterflow does not support Ubuntu because ofxs
# https://github.com/dthpham/butterflow/issues/2

# Minimal archlinux base with aur setup
FROM l3iggs/archlinux-aur
USER docker
RUN sudo pacman -Syu --noconfirm

# RUN if grep -q "grunt" package.json; then echo succeed; fi

RUN yaourt -S --noconfirm intel-opencl-runtime
RUN yaourt -S --noconfirm butterflow

# Fix problem with OpenCV lib
RUN sudo ln -s /dev/null /dev/raw1394
    
MAINTAINER Jarkko Saltiola
