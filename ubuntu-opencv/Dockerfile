# Ubuntu 14.04 base image
FROM ubuntu:14.04
MAINTAINER Jose Rivera <info@joserivera.org>

# Update packages and install basics
RUN apt-get update && apt-get install -y \
	wget \
	unzip \
	git

# Install dependencies
RUN apt-get install -y build-essential libgtk2.0-dev libjpeg-dev libtiff4-dev libjasper-dev libopenexr-dev cmake python-dev python-numpy python-tk libtbb-dev libeigen3-dev yasm libopencore-amrnb-dev libopencore-amrwb-dev libtheora-dev libvorbis-dev libxvidcore-dev libx264-dev libqt4-dev libqt4-opengl-dev sphinx-common texlive-latex-extra libv4l-dev libdc1394-22-dev libavcodec-dev libavformat-dev libswscale-dev default-jdk ant libvtk5-qt4-dev

# cd to /tmp and clone repos
WORKDIR /tmp
RUN git clone https://github.com/Itseez/opencv.git
RUN git clone https://github.com/Itseez/opencv_contrib.git

# Create build folder
WORKDIR /tmp/opencv
RUN mkdir /tmp/opencv/build 
WORKDIR /tmp/opencv/build

RUN cmake -D CMAKE_BUILD_TYPE=Release -D CMAKE_INSTALL_PREFIX=/usr/local -D WITH_TBB=ON -D BUILD_NEW_PYTHON_SUPPORT=ON -D WITH_V4L=ON -D INSTALL_C_EXAMPLES=ON -D BUILD_TESTS=ON -D INSTALL_PYTHON_EXAMPLES=ON -D WITH_QT=ON -D WITH_OPENGL=ON -D OPENCV_EXTRA_MODULES_PATH=/tmp/opencv_contrib/ ..

RUN make 
RUN make install
RUN echo "/usr/local/lib" > /etc/ld.so.conf.d/opencv.conf
RUN ldconfig

WORKDIR /
RUN rm -rf /tmp/*
