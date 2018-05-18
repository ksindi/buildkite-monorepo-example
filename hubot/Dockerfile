FROM node:8

ENV HUBOT_PATH /opt/hubot
ENV NODE_ENV production

RUN npm install -g coffeescript

WORKDIR ${HUBOT_PATH}

COPY package.json external-scripts.json ${HUBOT_PATH}/

RUN npm install

EXPOSE 8080

CMD ${HUBOT_PATH}/node_modules/hubot/bin/hubot --adapter slack
