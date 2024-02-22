FROM maven:3.8.1-openjdk-17-slim AS MAVEN_BUILD

RUN mkdir /sources
COPY ./ /sources

RUN echo "Building app..." && cd /sources && mvn clean package -DskipTest

FROM openjdk:17-oracle

WORKDIR /app
COPY --from=MAVEN_BUILD /sources/target/spad-iot-1.0.0-SNAPSHOT.jar /app/spad-iot-1.0.0-SNAPSHOT.jar
EXPOSE 8080

CMD ["java","-jar","spad-iot-1.0.0-SNAPSHOT.jar"]