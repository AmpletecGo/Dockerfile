FROM jumpserver/python:v3.6.1

RUN yum update -y && yum install epel-release -y && yum update -y && yum install wget unzip epel-release supervisor -y

RUN localedef -c -f UTF-8 -i zh_CN zh_CN.UTF-8
RUN export LC_ALL=zh_CN.UTF-8
RUN export LANG=zh_CN.UTF-8
RUN echo 'LANG="zh_CN.UTF-8"' > /etc/locale.conf
RUN echo 'LANG="zh_CN.UTF-8"' > /etc/sysconfig/i18n

WORKDIR /opt/

# 3. 下载包并解压
RUN wget https://github.com/jumpserver/jumpserver/archive/master.zip -O /opt/jumpserver.zip
RUN unzip jumpserver.zip && mv jumpserver-master jumpserver && rm -rf jumpserver.zip

# 4. 安装yum依赖
RUN yum -y install $(cat /opt/jumpserver/requirements/rpm_requirements.txt)

# 5. 安装pip依赖
RUN pip install --upgrade pip && pip install -r /opt/jumpserver/requirements/requirements.txt

VOLUME /opt/jumpserver/data
VOLUME /opt/jumpserver/logs

COPY config.py /opt/jumpserver/config.py
COPY entrypoint.sh /etc/entrypoint.sh

EXPOSE 8080

#CMD cd /opt/jumpserver/utils && sh make_migrations.sh && cd .. && python run_server.py
ENTRYPOINT ["entrypoint.sh"]
