FROM ubuntu:14.04
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
      libssl-dev \
      gcc-multilib \
      g++-multilib \
      libc6-dev \
      libc6-dev-i386 \
      pkg-config \
      libpng12-dev \
      libfreetype6-dev
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
# REQUIRE cmake>=3.1
