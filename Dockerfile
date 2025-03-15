# Use official openjdk base image
FROM openjdk:11-jre-slim

# Copy the JAR file from target folder
COPY target/demo-0.0.1-SNAPSHOT.jar /usr/app/demo.jar

# Set the working directory
WORKDIR /usr/app

# Expose the port on which the app will run
EXPOSE 8080

# Run the JAR file
ENTRYPOINT ["java", "-jar", "demo.jar"]
