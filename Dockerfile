FROM node:8-alpine

WORKDIR /app

COPY package.json ./

RUN apk --no-cache --virtual deps add \
      python \
      make \
      g++ \
      bash \
      git \
    && npm install

COPY . .

RUN npm run build \
    && rm -rf node_modules \
    && npm install --production \
    && apk del deps

ENTRYPOINT ["npm"]

CMD ["start"]
