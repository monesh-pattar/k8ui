FROM registry.access.redhat.com/ubi8/nodejs-16 AS build
USER root
RUN mkdir /app
WORKDIR /app


COPY package.json /app
RUN npm install
COPY . /app
RUN npm run build

FROM registry.redhat.io/rhel8/nginx-116
COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 8080

CMD ["nginx","-g", "daemon off;"]


