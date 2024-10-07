# Stage 1: Build the React application
FROM node:18 AS build

WORKDIR /usr/src/app

COPY package*.json ./
RUN npm install --production && npm cache clean --force && rm -rf /tmp/*

COPY . .
RUN npm run build

# Stage 2: Serve the React application using Nginx
FROM nginx:alpine

COPY --from=build /usr/src/app/build /usr/share/nginx/html

EXPOSE 80
