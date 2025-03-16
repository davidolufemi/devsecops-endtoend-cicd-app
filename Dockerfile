# Use official openjdk base image
FROM openjdk:11-jre-slim

# Set the working directory
WORKDIR /app

# Copy the dependencies
COPY pom.xml .

# Copy all files
COPY . .

# Build the application and package it into a .jar file
RUN mvn clean package -DskipTests

# Expose the port on which the app will run
EXPOSE 8080

# Run the JAR file
ENTRYPOINT ["java", "-jar", "app.jar"]
