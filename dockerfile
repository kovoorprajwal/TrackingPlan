FROM node:14-alpine

WORKDIR /app

COPY package.json package-lock.json ./

RUN npm install --production

COPY . .

CMD [ "npm", "start" ]

on:
  push:
    branches: [ main ]

jobs:

  build:

    runs-on: ubuntu-latest
    strategy:
      matrix:
        node-version: ['16.x']
    steps:
    - uses: actions/checkout@v2
    - name: Build the Docker image
      run: |
        echo "${{ secrets.DOCKER_HUB_TOKEN }}" | docker login -u "${{ secrets.DOCKER_HUB_USERNAME }}" --password-stdin docker.io
        docker build . --file Dockerfile --tag docker.io/${{ secrets.DOCKER_HUB_USERNAME }}/${{ secrets.DOCKER_HUB_REPOSITO
