FROM ubuntu:14.04
WORKDIR /challenge
RUN apt-get update \
 && apt-get install -y \
      wget \
      vim \
      cmake \
      python \
      python-pip \
      python-dev \
      build-essential \
      bash \
      clang \
      libssl-dev \
      gcc-multilib \
      g++-multilib \
      libc6-dev \
      libc6-dev-i386 \
      pkg-config \
      libpng12-dev \
      libfreetype6-dev
# install cmake 3.1
RUN cd /tmp \
 && wget http://www.cmake.org/files/v3.1/cmake-3.1.3.tar.gz \
 && tar xf cmake-3.1.3.tar.gz \
 && cd cmake-3.1.3 \
 && ./configure \
 && make \
 && make install \
 && rm -rf /tmp/*
COPY requirements.txt .
RUN pip install -r requirements.txt
COPY genpolls.sh /challenge/genpolls.sh
COPY build.sh /challenge/build.sh
COPY CMakeLists.txt /challenge/CMakeLists.txt
COPY tools tools
COPY include /challenge/include
COPY exclude /challenge/exclude
COPY challenges challenges
RUN ./build.sh
