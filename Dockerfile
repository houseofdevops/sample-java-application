# Stage 1: Build JAR using Maven
FROM maven:3.9.3-eclipse-temurin-17 AS builder
WORKDIR /app
COPY pom.xml .
COPY src ./src
RUN mvn clean package

# Stage 2: Minimal runtime image
FROM eclipse-temurin:17-jdk
WORKDIR /app
COPY --from=builder /app/target/simple-java-app-1.0.0.jar app.jar
ENTRYPOINT ["java", "-jar", "app.jar"]
