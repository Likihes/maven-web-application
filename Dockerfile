# Stage 1: Build the Maven application
FROM maven:3.8.6-eclipse-temurin-11 AS build

LABEL maintainer="your-email@example.com"
LABEL description="Dockerized Maven Web Application on Tomcat 9.0 with JDK 11"

WORKDIR /usr/src/app
COPY pom.xml .
COPY src ./src
RUN mvn clean package

# Stage 2: Run with Tomcat and JDK 11
FROM tomcat:9.0-jdk11-temurin

ENV APP_HOME=/usr/local/tomcat/webapps
ENV APP_NAME=maven-web-application

WORKDIR $APP_HOME
RUN useradd -m appuser
USER appuser

COPY --from=build /usr/src/app/target/${APP_NAME}*.war $APP_HOME/${APP_NAME}.war

EXPOSE 8080
CMD ["catalina.sh", "run"]

