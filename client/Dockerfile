# STAGE 1: Build
# We do an unnamed build and refer to it later as 0 beacuase
# of a reported bug on Elastic Beanstalk with named builds.
FROM node:alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY ./ ./
RUN npm run build

# STAGE 2: Deployment
FROM nginx
EXPOSE 3000
COPY ./nginx/default.conf /etc/nginx/conf.d/default.conf
COPY --from=0 /app/build /usr/share/nginx/html