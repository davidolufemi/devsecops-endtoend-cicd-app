# Use official Maven and OpenJDK base image
FROM maven:3.8-openjdk-11 as build

# Set the working directory for the Maven build process
WORKDIR /app

# Copy pom.xml first to leverage Docker cache for dependencies
COPY pom.xml .

# Install dependencies (dependencies will be cached if no changes in pom.xml)
RUN mvn dependency:go-offline

# Copy the rest of the application code
COPY . .

# Build the application and package it into a .jar file
RUN mvn clean install

# Debugging step: List the contents of the /app/target directory
RUN ls -l /app/target

# Use a smaller base image for the final runtime image
FROM openjdk:11-jre-slim

# Set the working directory for the app
WORKDIR /app

# Copy the JAR file from the previous build stage (from the target directory)
COPY --from=build /app/target/demo-0.0.1-SNAPSHOT.jar /app/app.jar

# Expose the port the app will run on
EXPOSE 8080

# Run the JAR file
ENTRYPOINT ["java", "-jar", "app.jar"]
