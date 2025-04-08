#1 - Build
FROM maven:3.9.4-eclipse-temurin-21-alpine AS build
RUN mkdir /app
WORKDIR /app

#Copy maven
COPY pom.xml .
COPY src ./src

#build
RUN mvn clean package

#2 - Run app
FROM maven:3.9.4-eclipse-temurin-21-alpine AS runtime
WORKDIR /app

#copy JAR
COPY target/*.jar /app/app.jar

#PORT
EXPOSE 8080

#Command
ENTRYPOINT ["java", "-jar","app.jar"]