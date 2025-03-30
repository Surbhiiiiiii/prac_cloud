# Use an official lightweight Node.js image
FROM node:18-alpine

# Set the working directory inside the container
WORKDIR /app

# Copy the JavaScript file into the container
COPY app.js .

# Command to run the script
CMD ["node", "app.js"]
