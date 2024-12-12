# Use the official Node.js image
FROM node:20 as runtime

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install --unsafe-perm=true

# Copy the rest of the application code
COPY . .

RUN npm run build

# Expose the port the app runs on
EXPOSE 3000


# Start the application
CMD ["npm", "start"]
