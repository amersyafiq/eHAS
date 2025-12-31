# ========= STAGE 1: Build the WAR with Maven =========
# Use official Maven image with JDK 21 (latest stable Maven ~3.9.x)
FROM maven:3.9-eclipse-temurin-21 AS builder

WORKDIR /app

# Copy pom.xml first for better Docker layer caching
COPY pom.xml .

# Download dependencies (cached if pom.xml unchanged)
RUN mvn dependency:go-offline -B

# Copy source code and build the WAR
COPY src ./src
RUN mvn clean package -DskipTests -B

# ========= STAGE 2: Runtime with Payara Server =========
# Latest Payara 7 Community (Jakarta EE 11 certified, Dec 2025)
FROM payara/server-full:latest

# Copy the built WAR to Payara's autodeploy directory
COPY --from=builder /app/target/*.war $DEPLOY_DIR/

# Expose ports
EXPOSE 8080 
EXPOSE 8181
EXPOSE 4848