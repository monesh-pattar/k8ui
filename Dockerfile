FROM registry.access.redhat.com/ubi8/nodejs-16 AS build
USER node
WORKDIR /app
COPY ./package.json .
 RUN sudo chmod -R 777 /home/node
RUN npm install

COPY . .

FROM registry.redhat.io/rhel8/nginx-116
COPY --from=build /app/build /usr/share/nginx/html

EXPOSE 80
CMD ["nginx","-g", "daemon off;"]

# EXPOSE 3000
# CMD ["npm", "start"]
