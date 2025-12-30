# Multi-stage Dockerfile for your Jakarta EE WAR project (eHAS)
# Stage 1: Build the WAR using slim Maven + Java 17 (matches your pom.xml compiler settings)

FROM maven:3-eclipse-temurin-17-alpine AS builder

WORKDIR /app

# Copy pom.xml first for dependency caching
COPY pom.xml .

# Resolve dependencies
RUN mvn dependency:go-offline -B

# Copy source code
COPY src ./src

# Build the WAR (skip tests if desired; remove -DskipTests to run them)
RUN mvn package -DskipTests -B

# DEBUG: List target contents to confirm WAR was built
RUN echo "=== Contents of /app/target/ ===" && \
    ls -la /app/target/ && \
    echo "=== WAR files ===" && \
    ls -la /app/target/*.war || echo "No .war files found"

# Stage 2: Runtime with Tomcat 11 (supports Jakarta EE 11)
# Uses Eclipse Temurin JDK 21 (current LTS as of Dec 2025) - smallest & secure
FROM tomcat:11.0-jdk21-temurin-jammy

# Optional: Remove default Tomcat apps to reduce size and attack surface
RUN rm -rf /usr/local/tomcat/webapps/*

# Copy your built WAR from builder stage
# Your artifactId is "eHAS", version "1.0-SNAPSHOT" → eHAS-1.0-SNAPSHOT.war
# Deploy as ROOT.war so app is available at http://localhost:8080/ (no /eHAS context)
# If you want /eHAS context, copy to eHAS.war instead
COPY --from=builder /app/target/eHAS-1.0-SNAPSHOT.war /usr/local/tomcat/webapps/ROOT.war

# Expose port 8080
EXPOSE 8080

# Tomcat starts automatically with the default CMD ["catalina.sh", "run"]