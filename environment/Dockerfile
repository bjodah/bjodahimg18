FROM ubuntu:bionic
MAINTAINER Björn Dahlgren <bjodah@DELETEMEgmail.com>
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true

COPY scripts/get_sundials.sh /opt/get_sundials.sh

RUN apt-get update && \
    apt-get --quiet --assume-yes install locales && \
    locale-gen en_US.UTF-8 && \
    echo "path-exclude /usr/share/doc/*" >/etc/dpkg/dpkg.cfg.d/01_nodoc && \
    echo "path-include /usr/share/doc/*/copyright" >>/etc/dpkg/dpkg.cfg.d/01_nodoc && \
    apt-get upgrade -y && \
    apt-get --assume-yes --no-install-recommends install wget curl ssh gnupg2 time sudo expect parallel zip unzip git \
    build-essential gfortran gfortran-8 gcc-8 g++-8 gcc-8-multilib g++-8-multilib libc6-dev-i386 gdb valgrind scons libtool automake  cmake flex bison binutils-dev \
    libreadline6-dev libyaml-dev libicu-dev zlib1g-dev libbz2-dev liblzma-dev lzma lzma-dev zstd libzstd-dev libncurses5-dev libsqlite3-dev libzmq3-dev \
    libssl-dev libgdbm-dev tk8.5-dev libxslt1-dev libxml2-dev libgit2-dev emacs-nox \
    liblapack-dev libopenmpi-dev libgmp-dev libmpfr-dev libgsl-dev coinor-libipopt-dev \
    petsc-dev trilinos-dev libsuitesparse-dev doxygen pandoc phantomjs \
    libjpeg-dev libpng-dev libfreetype6-dev libfontconfig1 fonts-dejavu fonts-humor-sans imagemagick ffmpeg \
    xorg-dev xutils-dev libxrender1 freeglut3-dev libglfw3-dev libgl1-mesa-dev \
    libsdl2-dev libsdl2-ttf-dev libsdl2-net-dev libsdl2-mixer-dev libsdl2-image-dev libsdl2-gfx-dev \
    texlive-generic-recommended texlive-latex-recommended texlive-science texlive-fonts-recommended \
    texlive-fonts-extra texlive-latex-extra texlive-lang-european lmodern texlive-bibtex-extra \
    texlive-xetex biber graphviz libgraphviz-dev dot2tex dvipng latexmk \
    python3-dev python3-pip python3-setuptools python3-wheel && \
    wget -O - https://apt.llvm.org/llvm-snapshot.gpg.key|sudo apt-key add - && \
    echo "deb http://apt.llvm.org/bionic/ llvm-toolchain-bionic-8 main" | tee -a /etc/apt/sources.list && \
    apt-get update && apt-get --quiet --assume-yes --no-install-recommends install \
        clang-8 libllvm8 lldb-8 llvm-8 llvm-8-dev llvm-8-runtime clang-format-8 \
        python-clang-8 && \
    python3 -m pip install --upgrade pip setuptools wheel && \
    python3 -m pip install setuptools wheel virtualenv future appdirs pybind11 cython \
            flake8 pytest pytest-pep8 pytest-cov pytest-flakes pytest-flake8 pytest-xdist \
            numpy numpydoc scipy statsmodels "sympy>=1.1.1,!=1.2" matplotlib mpld3 jupyter ipython ipykernel \
            scikit-optimize joblib toolz param quantities pylatex bokeh mogli xarray periodictable ase \
            tqdm pyparsing ipywidgets pulp holoviews[recommended] cclib scikit-image git-archive-all wurlitzer \
            sphinx sphinx_rtd_theme argh rstcheck check-manifest setuptools_scm mako bottle sqlalchemy CherryPy Nikola[extras] nbsphinx \
            networkx pygraphviz plotly nbconvert https://github.com/airspeed-velocity/asv/archive/d23bb8b74e8adacbfa3cf5724bda55fb39d56ba6.tar.gz && \
    python3 -m ipykernel install && \
    python3 -m jupyter nbextension enable --py widgetsnbextension && \
    echo "backend: Agg" > /etc/matplotlibrc && \
    mkdir -p /root/.config/matplotlib/ && cp /etc/matplotlibrc /root/.config/matplotlib/ && \
    python3 -c "import matplotlib.pyplot as plt" && \
    apt-get clean && \
    cd /tmp && curl -Ls https://github.com/symengine/symengine/releases/download/v0.4.0/symengine-0.4.0.tar.gz | tar xz && cd symengine-0.4.0 && mkdir build && cd build && \
    CC=gcc-8 CXX=g++-8 CMAKE_PREFIX_PATH=/usr/lib/llvm-8 cmake -DCMAKE_INSTALL_PREFIX=/opt/symengine-0.4.0 -DWITH_BFD=ON -DBUILD_SHARED_LIBS=ON -DWITH_LLVM=ON -DBUILD_TESTS=OFF -DBUILD_BENCHMARKS=OFF .. && make install && \
    curl -Ls https://github.com/catchorg/Catch2/releases/download/v2.7.2/catch.hpp -o /opt/catch2-2.7.2/include/catch.hpp --create-dirs && \
    curl -Ls https://github.com/catchorg/Clara/releases/download/v1.1.5/clara.hpp -o /opt/clara-1.1.5/include/clara.hpp --create-dirs && \
    curl -Ls https://github.com/nlohmann/json/releases/download/v3.6.1/json.hpp -o /opt/nlohmann_json-3.6.1/include/json.hpp --create-dirs && \
    cd /tmp && curl -Ls https://github.com/USCiLab/cereal/archive/v1.2.2.tar.gz | tar xz -C /opt/ && \
    cd /tmp && curl -Ls https://github.com/msgpack/msgpack-c/releases/download/cpp-3.1.1/msgpack-3.1.1.tar.gz | tar xz && cd msgpack-* && mkdir build && cd build/ && \
    cmake -DCMAKE_INSTALL_PREFIX:PATH="/opt/msgpack-3.1.1" .. && make install && \
    cd /tmp && curl -Ls https://github.com/abseil/abseil-cpp/archive/d902eb869bcfacc1bad14933ed9af4bed006d481.tar.gz | tar xz && cd abseil-cpp-* && mkdir build && cd build/ && \
    cmake -DCMAKE_INSTALL_PREFIX:PATH="/opt/abseil-cpp-d902eb8" .. && make install && \
    cd /tmp && curl -Ls http://bitbucket.org/eigen/eigen/get/3.3.7.tar.bz2 | tar xj && cd eigen-* && mkdir build && cd build/ && \
    cmake -DCMAKE_INSTALL_PREFIX:PATH="/opt/eigen-3.3.7" .. && make install && \
    cd /tmp && curl -Ls https://dl.bintray.com/boostorg/release/1.70.0/source/boost_1_70_0.tar.bz2 | tar xj && \
    cd boost_1_70_0 && ./bootstrap.sh --with-python=python3 --prefix=/opt/boost_1_70_0 && ./b2 install && cd - && \
    CC=gcc-8 /opt/get_sundials.sh 4.1.0 /opt/sundials-4.1.0-klu-lapack -DLAPACK_ENABLE=ON -DKLU_ENABLE=ON -DKLU_INCLUDE_DIR=/usr/include/suitesparse -DKLU_LIBRARY_DIR=/usr/lib/x86_64-linux-gnu -DSUNDIALS_INDEX_SIZE=32 && \
    CC=gcc-8 /opt/get_sundials.sh 3.2.1 /opt/sundials-3.2.1-klu-lapack -DLAPACK_ENABLE=ON -DKLU_ENABLE=ON -DKLU_INCLUDE_DIR=/usr/include/suitesparse -DKLU_LIBRARY_DIR=/usr/lib/x86_64-linux-gnu -DSUNDIALS_INDEX_SIZE=32 && \
    CC=gcc-8 /opt/get_sundials.sh 2.7.0 /opt/sundials-2.7.0-klu-lapack -DLAPACK_ENABLE=ON -DKLU_ENABLE=ON -DKLU_INCLUDE_DIR=/usr/include/suitesparse -DKLU_LIBRARY_DIR=/usr/lib/x86_64-linux-gnu -DSUNDIALS_INDEX_TYPE="int32_t" && \
    CC=gcc-8 /opt/get_sundials.sh 4.1.0 /opt/sundials-4.1.0-noklu-nolapack-extended-int64 -DLAPACK_ENABLE=OFF -DKLU_ENABLE=OFF -DSUNDIALS_PRECISION:STRING="extended" -DSUNDIALS_INDEX_SIZE=64 && \
    CC=gcc-8 /opt/get_sundials.sh 3.2.1 /opt/sundials-3.2.1-noklu-nolapack-extended-int64 -DLAPACK_ENABLE=OFF -DKLU_ENABLE=OFF -DSUNDIALS_PRECISION:STRING="extended" -DSUNDIALS_INDEX_SIZE=64 && \
    CC=gcc-8 /opt/get_sundials.sh 2.7.0 /opt/sundials-3.2.1-noklu-nolapack-extended-int64 -DLAPACK_ENABLE=OFF -DKLU_ENABLE=OFF -DSUNDIALS_PRECISION:STRING="extended" -DSUNDIALS_INDEX_TYPE="int64_t" -DBUILD_ARKODE=OFF && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache/pip