# FROM tomcat:8.0.20-jre8
# # [FROM defines the baseImage containing dependencies]
# COPY target/crispy.war /usr/local/tomcat/webapps/crispy.war
# COPY tomcat-users/tomcat-users.xml /usr/local/tomcat/conf/


# You can change this base image to anything else
# But make sure to use the correct version of Java
# FROM adoptopenjdk/openjdk11:alpine-jre
FROM tomcat:8.0.20-jre8

# Simply the artifact path
ARG artifact=target/crispy.war

WORKDIR /opt/app

COPY ${artifact} crispy.war

# This should not be changed
ENTRYPOINT ["java","-jar","app.jar"]
