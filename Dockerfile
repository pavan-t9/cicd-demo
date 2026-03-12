# Stage 1 - Build
FROM maven:3.9-eclipse-temurin-17 AS build
WORKDIR /app
COPY . .
RUN mvn clean package -DskipTests

# Stage 2 - Run
FROM eclipse-temurin:17-jre
WORKDIR /app
COPY --from=build /app/target/cicd-demo-1.0.jar app.jar
CMD ["java", "-jar", "app.jar"]
