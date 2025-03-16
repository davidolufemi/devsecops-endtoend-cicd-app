# Use official openjdk base image
FROM maven:3.8-openjdk-11 

# Copy the dependencies
COPY pom.xml .

# Copy all files
COPY . .

# Build the application and package it into a .jar file
RUN mvn clean install

# Set the working directory to where the .jar file is located
WORKDIR /app/target
RUN ls -l /app/target

# Expose the port on which the app will run
EXPOSE 8080

# Run the JAR file
ENTRYPOINT ["java", "-jar", "app.jar"]
