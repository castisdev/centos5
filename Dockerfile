# Pull base image
FROM centos:centos5

# Install EPEL repo
RUN rpm -ivh http://dl.fedoraproject.org/pub/epel/5/x86_64/epel-release-5-4.noarch.rpm

# Install
RUN \
  yum install -y sudo wget gcc gcc-c++ make unzip openssl openssl-devel;\
  yum install -y boost-devel glibc-devel.i386 e2fsprogs-devel.i386;\
  yum install -y git cppcheck;\
  yum -y clean all

ADD ./install_cmake30.sh /script/
RUN /script/install_cmake30.sh

ADD ./install_devtoolset2.sh /script/
RUN /script/install_devtoolset2.sh

ADD ./install_boost156.sh /script/
RUN /script/install_boost156.sh

ENV PATH /opt/rh/devtoolset-2/root/usr/bin/:$PATH
ENV BOOST_ROOT /usr/local/boost156

ADD ./install_cryptopp.sh /script/
RUN /script/install_cryptopp.sh

ADD ./install_gmock170.sh /script/
RUN /script/install_gmock170.sh

ADD ./install_python27.sh /script/
RUN /script/install_python27.sh

ADD ./install_cpptools.sh /script/
RUN /script/install_cpptools.sh

# Add root files
ADD ./.bashrc /root/.bashrc

# Set environment variables
ENV HOME /root

# Define default command
CMD ["bash"]
