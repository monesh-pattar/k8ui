FROM registry.access.redhat.com/ubi8/nodejs-16 AS build
WORKDIR /app
USER root
COPY ./package.json /app
RUN npm install

COPY . .

FROM registry.redhat.io/rhel8/nginx-116
COPY --from=build /app/build /usr/share/nginx/html
ENV PORT="8080"
EXPOSE 8080


CMD ["nginx","-g", "daemon off;"]

# EXPOSE 3000
# CMD ["npm", "start"]
