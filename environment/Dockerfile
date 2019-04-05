FROM ubuntu:bionic
MAINTAINER Björn Dahlgren <bjodah@DELETEMEgmail.com>
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8
ENV DEBIAN_FRONTEND noninteractive
ENV DEBCONF_NONINTERACTIVE_SEEN true
RUN apt-get update && \
    apt-get --quiet --assume-yes install locales && \
    locale-gen en_US.UTF-8 && \
    echo "path-exclude /usr/share/doc/*" >/etc/dpkg/dpkg.cfg.d/01_nodoc && \
    echo "path-include /usr/share/doc/*/copyright" >>/etc/dpkg/dpkg.cfg.d/01_nodoc && \
    apt-get upgrade -y && \
    apt-get --assume-yes --no-install-recommends install wget curl ssh gnupg2 time sudo expect parallel zip unzip git \
    build-essential gfortran gfortran-8 gcc-8 g++-8 gdb valgrind scons libtool cmake flex bison binutils-dev \
    libreadline6-dev libyaml-dev libicu-dev zlib1g-dev libbz2-dev liblzma-dev lzma lzma-dev zstd libzstd-dev libncurses5-dev libsqlite3-dev libzmq3-dev \
    libssl-dev libgdbm-dev tk8.5-dev libxslt1-dev libxml2-dev \
    liblapack-dev libopenmpi-dev libgmp-dev libmpfr-dev libgsl-dev coinor-libipopt-dev \
    libboost-all-dev libsuitesparse-dev doxygen pandoc phantomjs \
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
            networkx pygraphviz plotly nbconvert && \
    python3 -m ipykernel install && \
    python3 -m jupyter nbextension enable --py widgetsnbextension && \
    echo "backend: Agg" > /etc/matplotlibrc && \
    mkdir -p /root/.config/matplotlib/ && cp /etc/matplotlibrc /root/.config/matplotlib/ && \
    python3 -c "import matplotlib.pyplot as plt" && \
    apt-get clean && \
    cd /tmp && curl -Ls https://dl.bintray.com/boostorg/release/1.69.0/source/boost_1_69_0.tar.bz2 | tar xj && \
    cd boost_1_69_0 && ./bootstrap.sh --prefix=/opt/boost_1_69_0 && ./b2 install >b2_build.log && tail b2_build.log && \
    rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/* ~/.cache/pip