# Stage 1: Build the Maven application
FROM maven:3.8.6-eclipse-temurin-17 AS build

# Add labels for metadata
LABEL maintainer="your-email@example.com"
LABEL description="Dockerized Maven Web Application on Tomcat 9.0 with JDK 11"

# Set the working directory for the build
WORKDIR /usr/src/app

# Copy the Maven project files
COPY pom.xml .
COPY src ./src

# Build the WAR file
RUN mvn clean package

# Stage 2: Prepare the Tomcat runtime environment
FROM tomcat:10.1-jdk17-temurin

# Set environment variables
ENV APP_HOME=/usr/local/tomcat/webapps
ENV APP_NAME=maven-web-application

# Set the working directory
WORKDIR $APP_HOME

# Create a new user and set it as the default user
RUN useradd -m appuser
USER appuser

# Copy the WAR file from the build stage to the Tomcat webapps directory
COPY --from=build /usr/src/app/target/${APP_NAME}*.war $APP_HOME/${APP_NAME}.war

# Expose the port that Tomcat runs on
EXPOSE 8080

# Command to start Tomcat
CMD ["catalina.sh", "run"]



