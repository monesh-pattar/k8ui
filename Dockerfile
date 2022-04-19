FROM registry.access.redhat.com/ubi8/nodejs-16 AS build
WORKDIR /app
COPY ./package.json .
RUN npm install
COPY . .
RUN npm run build

FROM registry.redhat.io/rhel8/nginx-116
COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80
CMD ["nginx","-g", "daemon off;"]

# EXPOSE 3000
# CMD ["npm", "start"]
