FROM openjdk:8-jdk-alpine
ARG JAR_FILE=target/*.jar
COPY ${JAR_FILE} app.jar
ARG INPUT_FILE=inputfile
COPY ${INPUT_FILE} inputfile
ENTRYPOINT ["java","-jar","/app.jar"]