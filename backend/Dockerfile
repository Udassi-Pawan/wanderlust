# Use the official Node.js image as the base image
FROM node:20.12.2-alpine3.19

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to install dependencies
COPY package.json ./

# Install application dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Expose the port your Express app listens on
EXPOSE 8080

# Command to run the application when the container starts
CMD ["npm", "run", "dev"]