FROM ubuntu:18.04
WORKDIR /challenge
RUN apt-get update \
 && apt-get install -y \
      vim \
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
COPY build.sh /challenge/build.sh
COPY CMakeLists.txt /challenge/CMakeLists.txt
COPY tools tools
COPY include /challenge/include
COPY exclude /challenge/exclude
# COPY challenges/3D_Image_Toolkit /challenge/code
COPY challenges challenges
RUN ./build.sh
