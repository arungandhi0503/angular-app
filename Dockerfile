# Step 1: Use a base image with Node.js
FROM node:16 as build

# Step 2: Set the working directory in the container
WORKDIR /app

# Step 3: Copy package.json and package-lock.json (or yarn.lock)
COPY package*.json ./

# Step 4: Install dependencies
RUN npm install

# Step 5: Copy the rest of the application code
COPY . .

# Step 6: Build the application (React/Angular)
RUN npm run build

# Step 7: Use a lightweight server image to serve the static files
FROM nginx:alpine

# Step 8: Copy the built files from the build stage to Nginx's default directory
COPY --from=build /app/build /usr/share/nginx/html  

# Step 9: Expose port 80
EXPOSE 80

# Step 10: Start Nginx
CMD ["nginx", "-g", "daemon off;"]
