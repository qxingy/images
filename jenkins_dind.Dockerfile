FROM docker:latest
MAINTAINER qxingy

ENV JENKINS_HOME=/var/jenkins_home
ENV JENKINS_VERSION=2.342

ADD http://mirrors.tencentyun.com/apache/tomcat/tomcat-9/v9.0.62/bin/apache-tomcat-9.0.62.tar.gz tomcat.tar.gz

RUN echo -e "http://mirrors.tencentyun.com/alpine/v3.15/community\n"\
"http://mirrors.tencentyun.com/alpine/v3.15/main" > /etc/apk/repositories \
    && apk update && apk add --no-cache openjdk8 git \
    && mkdir tomcat && tar -zxvf tomcat.tar.gz --strip-components 1 -C tomcat && rm tomcat.tar.gz \
    && rm -rf /tomcat/webapps/ROOT

ADD http://mirrors.tencentyun.com/jenkins/war/2.342/jenkins.war tomcat/webapps/ROOT.war

EXPOSE 8080
VOLUME /var/jenkins_home

CMD /tomcat/bin/startup.sh ; tail -f /tomcat/logs/catalina.out
