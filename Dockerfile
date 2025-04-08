#1 - Build
FROM maven:3.9.4-eclipse-temurin-21-alpine AS builder
RUN mkdir /app
WORKDIR /app

#Copy maven
COPY pom.xml .
COPY src ./src

#build
RUN mvn clean package

#2 - Run app
FROM maven:3.9.4-eclipse-temurin-21-alpine AS runner

ARG GROUP__ID="br.com.rafael"
ARG ARTIFACT__ID="appAPI"
ARG FINAL__NAME="api-0.0.1-SNAPSHOT."

WORKDIR /app

#copy JAR
COPY target/$(FINAL__NAME).jar /app/app.jar

#PORT
EXPOSE 8080

#Command
ENTRYPOINT ["java", "-jar","app.jar"]