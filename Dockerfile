FROM ubuntu:20.04

WORKDIR /home/samples/srcs

RUN apt update; DEBIAN_FRONTEND=noninteractive apt install -y vim wget unzip ffmpeg autoconf libtool lld clang pkg-config cmake build-essential git libva-dev libdrm-dev wayland-protocols libx11-dev libx11-xcb-dev libxcb-present-dev libxcb-dri3-dev xorg xorg-dev libgl1-mesa-glx libgl1-mesa-dev

RUN wget https://github.com/intel/gmmlib/archive/refs/tags/intel-gmmlib-22.2.0.zip
RUN unzip intel-gmmlib-22.2.0.zip
RUN cd gmmlib-intel-gmmlib-22.2.0/; mkdir build; cd build; cmake -DCMAKE_BUILD_TYPE=Release -Darch=64  ..; make -j`nproc`; make install

RUN wget https://github.com/intel/libva/archive/refs/tags/2.16.0.zip
RUN unzip 2.16.0.zip
RUN cd libva-2.16.0/; ./autogen.sh; ./configure --prefix=/usr --libdir=/usr/lib/x86_64-linux-gnu/; make; make install
RUN rm *.zip

RUN wget https://github.com/intel/libva-utils/archive/refs/tags/2.16.0.zip
RUN unzip 2.16.0.zip
RUN cd libva-utils-2.16.0; ./autogen.sh; ./configure --prefix=/usr; make -j`nproc`; make install

RUN wget https://github.com/intel/media-driver/archive/refs/tags/intel-media-22.5.4.zip
RUN unzip intel-media-22.5.4.zip
RUN mkdir build_media
RUN cd build_media; cmake ../media-driver-intel-media-22.5.4 -DCMAKE_INSTALL_PREFIX=/usr -DMEDIA_VERSION="2.0.0" -DBS_DIR_INC=`pwd`/../gmmlib-intel-gmmlib-22.2.0/Source/inc -DBS_DIR_COMMON=`pwd`/../gmmlib-intel-gmmlib-22.2.0/Source/Common/ -DBS_DIR_GMMLIB=`pwd`/../gmmlib-intel-gmmlib-22.2.0/Source/GmmLib/; make -j`nproc`; make install

RUN wget https://github.com/oneapi-src/oneVPL/archive/refs/tags/v2022.2.2.zip
RUN unzip v2022.2.2.zip
RUN cd oneVPL*; export VPL_INSTALL_DIR=`pwd`/../_vplinstall; mkdir _build; mkdir $VPL_INSTALL_DIR; cd _build; cmake .. -DCMAKE_INSTALL_PREFIX=$VPL_INSTALL_DIR; cmake --build . --config Release; cmake --build . --config Release --target install

RUN wget https://github.com/oneapi-src/oneVPL-intel-gpu/archive/refs/tags/intel-onevpl-22.5.4.zip
RUN unzip intel-onevpl-22.5.4.zip
RUN cd oneVPL-intel-gpu*; mkdir build; cd build; cmake ..; make -j`nproc`; make install
COPY test-decode.sh /home/samples/srcs/test-decode.sh 

ENV LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/home/samples/srcs/_vplinstall/lib/:/opt/intel/mediasdk/lib
