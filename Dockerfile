FROM node:14-alpine as builder

WORKDIR /usr/src/app

# Build the project
RUN npm run build

FROM nginx:stable-alpine

# Copy conf file  
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Remove default nginx index page
RUN rm -rf /usr/share/nginx/html/*

# Copy build files from stage 1
COPY . /usr/share/nginx/html

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]