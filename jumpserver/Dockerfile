FROM centos:7

# 1. 安装基本依赖
RUN yum update -y && yum install epel-release -y && yum update -y && yum install wget unzip epel-release redis sqlite-devel xz gcc automake autoconf libtool make zlib-devel openssl-devel supervisor -y
WORKDIR /opt/

# 2. 准备python
RUN wget https://www.python.org/ftp/python/3.6.1/Python-3.6.1.tar.xz -O /opt/Python-3.6.1.tar.xz
RUN tar xf Python-3.6.1.tar.xz  && cd Python-3.6.1 && ./configure && make && make install
RUN python3 -m venv py3

# 3. 下载包并解压
RUN wget https://github.com/jumpserver/jumpserver/archive/master.zip -O /opt/jumpserver.zip
RUN unzip jumpserver.zip && mv jumpserver-master jumpserver

# 4. 安装yum依赖
RUN yum -y install $(cat /opt/jumpserver/requirements/rpm_requirements.txt)

# 5. 安装pip依赖
RUN source /opt/py3/bin/activate && pip install --upgrade pip && pip install -r /opt/jumpserver/requirements/requirements.txt

VOLUME /opt/jumpserver/data

COPY supervisord.conf /etc/supervisord.conf
COPY config.py /opt/jumpserver/config.py
COPY entrypoint.sh /bin/entrypoint.sh
RUN chmod +x /bin/entrypoint.sh

ENV REDIS_HOST=127.0.0.1 REDIS_PORT=6379

EXPOSE 2222 80
ENTRYPOINT ["entrypoint.sh"]
