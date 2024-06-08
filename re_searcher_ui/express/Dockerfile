# Dockerfile

FROM node:18.16.0-alpine3.17

WORKDIR /express

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3000

CMD [ "npm", "start"]