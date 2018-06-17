FROM jumpserver/python:v3.6.1
MAINTAINER ArYing Cosmos <rj05116@163.com>

RUN yum update -y && yum install epel-release -y && yum update -y && yum install wget unzip epel-release supervisor -y
WORKDIR /opt/

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

EXPOSE 8080
ENTRYPOINT ["entrypoint.sh"]
