# Use the official Node.js image
FROM node:20 as build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install --unsafe-perm=true

# Copy the rest of the application code
COPY . .

RUN npm run build

FROM node:20 as runtime

COPY --from=build /app/build /app
COPY --from=build /app/node_modules /app

# Expose the port the app runs on
EXPOSE 3000

RUN chown -R node /app/build && \
 chown -R node /app/node_modules

USER node:0

# Start the application
CMD ["npm", "start"]
