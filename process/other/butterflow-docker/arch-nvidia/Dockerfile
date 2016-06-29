# Dockerfile for butterflow motion interpolation tool.
# Butterflow does not support Ubuntu because of:
# https://github.com/dthpham/butterflow/issues/2

# THIS FILE IS IN PROGRESS AND PROBABLY WON'T WORK

# Minimal archlinux base with aur setup
FROM l3iggs/archlinux-aur
USER docker
RUN sudo pacman -Syu --noconfirm

RUN yaourt -S --noconfirm opencl-nvidia
RUN yaourt -S --noconfirm opencl-headers
RUN yaourt -S --noconfirm butterflow

# Fix problem with OpenCV lib
RUN sudo ln -s /dev/null /dev/raw1394
    
MAINTAINER Jarkko Saltiola
