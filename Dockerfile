FROM centos:6

MAINTAINER Filipe Fernandes <ocefpaf@gmail.com>

RUN yum -y update && yum clean all

# Some build tools.
RUN yum install -y tar bzip2 patch file make gcc-c++ wget git libtool texinfo which
RUN yum groupinstall -y 'Development Tools'

RUN wget http://bit.ly/miniconda -O miniconda.sh
RUN bash miniconda.sh -b -p /opt/conda && rm miniconda.sh
RUN /opt/conda/bin/conda update --yes --all
RUN /opt/conda/bin/conda config --add channels ioos --force
RUN /opt/conda/bin/conda install -c http://conda.binstar.org/pelson/channel/development --yes --quiet obvious-ci
RUN PATH=/opt/conda/bin:$PATH obvci_install_conda_build_tools.py

# Qt, matplotlib, and vispy.
RUN yum install -y libXext libSM libXrender fontconfig mesa-libGL

# octant.
RUN yum install -y gcc-gfortran

# udunits2.
RUN yum install -y expat-devel

# nco.
RUN yum install -y bison byacc flex antlr

ENV PATH /opt/conda/bin:$PATH
ENV LANG C.UTF-8
