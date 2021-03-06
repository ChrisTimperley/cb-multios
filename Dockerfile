FROM ubuntu:14.04
WORKDIR /challenge
RUN apt-get update \
 && apt-get install -y wget \
 && wget -O - http://llvm.org/apt/llvm-snapshot.gpg.key | apt-key add - \
 && echo "deb http://llvm.org/apt/trusty/ llvm-toolchain-trusty-3.8 main" >> /etc/apt/sources.list \
 && apt-get update \
 && apt-get install -y \
      vim \
      cmake \
      python \
      python-pip \
      python-dev \
      build-essential \
      bash \
      clang-3.8 \
      lldb-3.8 \
      libssl-dev \
      gdb \
      gcc-multilib \
      g++-multilib \
      libc6-dev \
      libc6-dev-i386 \
      pkg-config \
      libpng12-dev \
      libfreetype6-dev \
 && ln -s /usr/bin/clang-3.8 /usr/bin/clang \
 && ln -s /usr/bin/clang++-3.8 /usr/bin/clang++ \
 && apt-get clean \
 && rm -rf /var/lib/apt/lists/*
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
RUN pip install -r requirements.txt \
 && pip install matplotlib==2.2.3
# install clang-3.8:i386
RUN dpkg --add-architecture i386 \
 && apt-get update \
 && apt-get remove -y clang-3.8 lldb-3.8 \
 && apt-get autoremove -y \
 && apt-get install -y --no-install-recommends binutils:i386 \
 && apt-get install -y --no-install-recommends clang-3.8:i386
COPY genpolls.sh /challenge/genpolls.sh
COPY build.sh /challenge/build.sh
COPY CMakeLists.txt /challenge/CMakeLists.txt
COPY tools tools
COPY include /challenge/include
COPY exclude /challenge/exclude
COPY challenges challenges
RUN ./build.sh
COPY makepolls.sh .
RUN ./genpolls.sh || exit 0
COPY test.sh .
COPY instrument.sh .
