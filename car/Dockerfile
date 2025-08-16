# Stage 1: Build the application
# FROM eclipse-temurin:21-jdk-alpine AS build

# # Set the volume for the temporary directory
# VOLUME /tmp

# # Set the working directory in the container
# WORKDIR /app

# # Copy the Maven project files
# COPY mvnw .
# COPY .mvn .mvn
# COPY pom.xml .
# COPY src src

# # Install the dependencies and build the application
# RUN ./mvnw install -DskipTests

# Stage 2: Create the final image (prod)
# Production image
FROM eclipse-temurin:21-jdk-alpine AS prod
WORKDIR /app
ARG SPRING_PROFILES_ACTIVE
ENV SPRING_PROFILES_ACTIVE=${SPRING_PROFILES_ACTIVE}

# Copy pre-built JAR from Jenkins workspace
COPY *.jar app.jar

EXPOSE 8802
ENTRYPOINT ["java", "-jar", "app.jar"]
