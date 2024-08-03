FROM ubuntu:latest

ARG DEFAULT_TZ=America/Sao_Paulo
ENV DEFAULT_TZ=$DEFAULT_TZ

RUN apt-get update \
   && DEBIAN_FRONTEND=noninteractive TZ=$DEFAULT_TZ apt-get install -y \
   tzdata \
   vim \
   nano \
   sudo \
   curl \
   wget \
   git \
   make \
   cmake\
   patchelf && \
   rm -rf /var/lib/apt/lists/*

# Download the latest version of minicoda py3.8 for linux x86/x64.
RUN curl -fsSL https://repo.anaconda.com/miniconda/$( wget -O - https://repo.anaconda.com/miniconda/ 2>/dev/null | grep -o 'Miniconda3-py38_[^"]*-Linux-x86_64.sh' | head -n 1) > /tmp/miniconda.sh \
       && chmod +x /tmp/miniconda.sh \
       && /tmp/miniconda.sh -b -p /opt/conda

ENV PATH=/opt/conda/bin:$PATH
RUN conda init


RUN curl -s https://get.modular.com | sh -
RUN modular install mojo

ARG MODULAR_HOME="/root/.modular"
ENV MODULAR_HOME=$MODULAR_HOME
ENV PATH="$PATH:$MODULAR_HOME/pkg/packages.modular.com_mojo/bin"


ENV RAYLIB_TAR="raylib-5.0_linux_amd64.tar.gz"
ENV RAYLIB_URI="https://github.com/raysan5/raylib/releases/download/5.0/$RAYLIB_TAR"

RUN wget $RAYLIB_URI -O /tmp/$RAYLIB_TAR && \
    tar -xzvf /tmp/$RAYLIB_TAR -C /tmp && \
    rm /tmp/$RAYLIB_TAR


