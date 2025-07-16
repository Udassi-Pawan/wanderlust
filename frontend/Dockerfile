# Use the official Node.js image as the base image
FROM node:20-alpine

# Set the working directory inside the container
WORKDIR /usr/src/app

# Copy package.json and package-lock.json to install dependencies
COPY package.json ./

# Install application dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Copy .env.sample to .env
# RUN cp .env.sample .env

# Expose the port your Express app listens on
EXPOSE 5173

# Command to run the application when the container starts
CMD ["npm", "run", "dev"]