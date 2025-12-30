# === STAGE 1: Build the application ===
FROM maven:3.9-eclipse-temurin-17 AS build

WORKDIR /app

# Copy pom.xml and download dependencies (best caching)
COPY pom.xml .
RUN mvn dependency:go-offline -B

# Copy source code
COPY src ./src

# Build the JAR (skip tests for faster CI)
RUN mvn package -DskipTests -B

# === STAGE 2: Runtime image ===
FROM eclipse-temurin:17-jre-slim AS runtime

WORKDIR /app

# Copy the actual JAR file (using wildcard safely)
COPY --from=build /app/target/*.jar app.jar

# Expose port (helps tools like Docker & Kubernetes)
EXPOSE 8080

# Best practice: Run as non-root user for security
RUN addgroup --system appgroup && adduser --system --ingroup appgroup appuser
USER appuser

# Run the app
ENTRYPOINT ["java", "-jar", "app.jar"]