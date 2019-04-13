FROM centos:6.6
MAINTAINER showwin <showwin.czy@gmail.com>

# set timezone JST
RUN /bin/cp -p  /usr/share/zoneinfo/Japan /etc/localtime

RUN yum update -y && \
    rpm -ivh http://dl.fedoraproject.org/pub/epel/6/x86_64/epel-release-6-8.noarch.rpm

# install tools
RUN yum install -y --enablerepo=epel git tar bzip2 gcc-c++ make ruby-devel readline-devel unzip
RUN yum install -y --enablerepo=epel openssl-devel patch mysql-devel qt-devel wget xorg-x11-fonts-75dpi xorg-x11-fonts-Type1 libXext libXrender libpng libjpeg-turbo

# install wkhtmltopdf
RUN cd /usr/local/src/ && \
    wget http://download.gna.org/wkhtmltopdf/0.12/0.12.2.1/wkhtmltox-0.12.2.1_linux-centos6-amd64.rpm && \
    rpm -ivh wkhtmltox-0.12.2.1_linux-centos6-amd64.rpm && \
    ln -s /usr/local/bin/wkhtmltopdf /usr/bin/wkhtmltopdf
# add font
RUN wget http://dl.ipafont.ipa.go.jp/IPAexfont/IPAexfont00301.zip && \
    unzip IPAexfont00301.zip && \
    cp -rf IPAexfont00301/ /usr/share/fonts/

# install ruby-build & phantomjs
RUN git clone https://github.com/sstephenson/ruby-build.git /tmp/ruby-build && \
    cd /tmp/ruby-build && \
    ./install.sh && \
    cd / && \
    rm -rf /tmp/ruby-build && \
    curl -L -O https://bitbucket.org/ariya/phantomjs/downloads/phantomjs-1.9.7-linux-x86_64.tar.bz2 && \
    tar jxfv phantomjs-1.9.7-linux-x86_64.tar.bz2 && \
    cp phantomjs-1.9.7-linux-x86_64/bin/phantomjs /usr/local/bin/phantomjs

# for capybara-webkit
RUN echo "[epel-qt48]" >> /etc/yum.repos.d/qt.repo && \
    echo "name=Software Collection for Qt 4.8" >> /etc/yum.repos.d/qt.repo && \
    echo "baseurl=http://repos.fedorapeople.org/repos/sic/qt48/epel-6/x86_64/" >> /etc/yum.repos.d/qt.repo && \
    echo "enabled=1" >> /etc/yum.repos.d/qt.repo && \
    echo "skip_if_unavailable=1" >> /etc/yum.repos.d/qt.repo && \
    echo "gpgcheck=0" >> /etc/yum.repos.d/qt.repo && \
    echo "[epel-qt48-source]" >> /etc/yum.repos.d/qt.repo && \
    echo "name=Software Collection for Qt 4.8 - Source" >> /etc/yum.repos.d/qt.repo && \
    echo "baseurl=http://repos.fedorapeople.org/repos/sic/qt48/epel-6/SRPMS" >> /etc/yum.repos.d/qt.repo && \
    echo "enabled=0" >> /etc/yum.repos.d/qt.repo && \
    echo "skip_if_unavailable=1" >> /etc/yum.repos.d/qt.repo && \
    echo "gpgcheck=0" >> /etc/yum.repos.d/qt.repo && \
    yum install -y --enablerepo=epel qt48-qt-webkit-devel && \
    ln -s /opt/rh/qt48/root/usr/include/QtCore/qconfig-64.h  /opt/rh/qt48/root/usr/include/QtCore/qconfig-x86_64.h && \
    source /opt/rh/qt48/enable && \
    cp /opt/rh/qt48/root/usr/bin/qmake-qt4 /usr/local/bin/qmake

WORKDIR /app

# Install ruby & base gems
RUN git clone https://github.com/rbenv/rbenv.git ~/.rbenv && \
    cd ~/.rbenv && src/configure && make -C src && \
    echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc && \
    echo 'eval "$(rbenv init -)"' >> ~/.bashrc && \
    source ~/.bashrc && \
    mkdir -p "$(rbenv root)"/plugins && \
    git clone https://github.com/rbenv/ruby-build.git "$(rbenv root)"/plugins/ruby-build && \
    rbenv install 2.4.6 && \
    rbenv global 2.4.6 && \
    gem install bundler -v '< 2.0'

# use bundle container & set RAILS_ENV
ENV BUNDLE_JOBS=2 \
    RAILS_ENV=development

# bundle
ADD Gemfile* /app/
RUN source ~/.bashrc && bundle install --jobs 20 --retry 5

# Rails app
ADD . /app
