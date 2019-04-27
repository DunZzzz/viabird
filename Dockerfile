#
# Dockerfile
# Copyright (C) 2019 emilien <emilien@emilien-pc>
#
# Distributed under terms of the MIT license.
#

FROM node:10.11.0

WORKDIR /usr/app

COPY ./package.json .

RUN npm install

COPY . .
