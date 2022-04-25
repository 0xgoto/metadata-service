## BUILD STAGE
FROM maven:3-jdk-8-alpine as build
WORKDIR /usr/app/src
COPY pom.xml .
RUN mvn dependency:go-offline -B
COPY . .
RUN mvn package -DskipTests

## RUN STAGE
FROM openjdk:8-jdk-alpine
WORKDIR /usr/app/src
COPY --from=build /usr/app/src/target/metadata-service.jar .
ENTRYPOINT java -jar ./metadata-service.jar