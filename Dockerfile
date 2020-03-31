# Pull base image.
FROM node:10.1
WORKDIR /home/app
COPY . /home/app
#RUN rm package-lock.json
RUN ls

# Install all tools needed
RUN apt-get update
RUN apt-get --assume-yes install apt-utils
RUN apt-get --assume-yes install curl
RUN apt-get --assume-yes install nodejs
RUN apt-get --assume-yes install npm


RUN mv ./node_modules ./node_modules.tmp \
  && mv ./node_modules.tmp ./node_modules \
  && npm install
RUN curl https://install.meteor.com/ | sh
RUN meteor npm install
RUN meteor npm install --save babel-types babel-traverse babylon \
  cordova-registry-mapper cordova-lib cordova-common selenium-webdriver \
  phantomjs-prebuilt browserstack-webdriver browserstack-local system webpage \
  node-sass fibers
RUN npm install lstat
RUN meteor npm install lstat



#Remove meteor local
RUN rm -rf .meteor/local

RUN cd /var/lib
RUN mkdir -p /data/db

ENV PORT=3000
ENV ROOT_URL=http://localhost:3000

RUN npm start
