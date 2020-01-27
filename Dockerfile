FROM centos:7

# rubyのバージョンを指定
ENV RUBY_VERSION="2.7.0"

# 必要なパッケージをインストール
RUN yum -y update
RUN yum -y install git make autoconf wget
RUN yum -y install bzip2 gcc openssl-devel readline-devel zlib-devel

# rbenvのインストール
RUN git clone https://github.com/rbenv/rbenv.git /usr/local/rbenv
# ruby-buildのインストール
RUN git clone https://github.com/rbenv/ruby-build.git /usr/local/rbenv/plugins/ruby-build

# PATH設定
# コマンドでrbenvが使えるように設定
RUN echo 'export RBENV_ROOT="/usr/local/rbenv"' >> /etc/profile.d/rbenv.sh
RUN echo 'export PATH="${RBENV_ROOT}/bin:${PATH}"' >> /etc/profile.d/rbenv.sh
RUN echo 'eval "$(rbenv init -)"' >> /etc/profile.d/rbenv.sh
RUN source /etc/profile.d/rbenv.sh; rbenv install $RUBY_VERSION; rbenv global $RUBY_VERSION
RUN source /etc/profile.d/rbenv.sh; gem update --system
