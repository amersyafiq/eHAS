# Stage 1: Build the WAR (same as before)
FROM maven:3-eclipse-temurin-17-alpine AS builder

WORKDIR /app

COPY pom.xml .
RUN mvn dependency:go-offline -B

COPY src ./src

RUN mvn package -DskipTests -B

# DEBUG: List target contents
RUN echo "=== Contents of /app/target/ ===" && \
    ls -la /app/target/ && \
    ls -la /app/target/*.war || echo "No .war found"

# Stage 2: Runtime with official Eclipse GlassFish (Jakarta EE 11 compatible)
# Latest tag points to the most recent GlassFish 8.x milestone/release supporting Jakarta EE 11
FROM ghcr.io/eclipse-ee4j/glassfish:latest

# Remove default apps (optional, reduces noise)
RUN rm -rf /glassfish/domains/domain1/autodeploy/*

# Copy your WAR and rename to ROOT.war for root context[](http://host/)
# Or use eHAS-1.0-SNAPSHOT.war for http://host/eHAS-1.0-SNAPSHOT/
COPY --from=builder /app/target/eHAS-1.0-SNAPSHOT.war /glassfish/domains/domain1/autodeploy/ROOT.war

# Expose ports (8080 HTTP, 4848 admin console - optional for production)
EXPOSE 8080 4848

# GlassFish starts automatically via the base image's ENTRYPOINT/CMD