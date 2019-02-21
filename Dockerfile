FROM ubuntu:18.04
WORKDIR /challenge
COPY build.sh /challenge/build.sh
COPY challenges/3D_Image_Toolkit /challenge/code
RUN apt-get update \
 && apt-get install -y \
      cmake \
      python \
      python-pip \
      python-dev \
      build-essential \
      bash \
      clang \
      gcc-multilib \
      g++-multilib \
      libc6-dev \
      libc6-dev-i386
RUN pip install xlsxwriter pycrypto
COPY CMakeLists.txt /challenge/CMakeLists.txt
COPY include /challenge/include
COPY exclude /challenge/exclude
RUN ./build.sh
