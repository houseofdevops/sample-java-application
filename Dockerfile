# Stage 1: Build the JAR file using Maven
FROM maven:3.9.3-eclipse-temurin-17 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package -DskipTests

# Stage 2: Runtime image
FROM eclipse-temurin:17-jdk
ENV APP_HOME=/usr/src/app
WORKDIR $APP_HOME
COPY --from=builder /app/target/*.jar $APP_HOME/app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]

