FROM tomcat:8.0.43-jre8
MAINTAINER Hemant
RUN mkdir /home/app
WORKDIR /home/app
COPY ./target/*.war /usr/local/tomcat/webapps/
EXPOSE 8080
CMD chmod +x /usr/local/tomcat/bin/catalina.sh
CMD ["catalina.sh", "run"]
