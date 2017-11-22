FROM ubuntu:latest
MAINTAINER Brian Hopkins "brianhh1230@gmail.com"
RUN \
apt-get update -y && \
apt-get install -y python3-pip python3-dev build-essential git
COPY . /app
WORKDIR /app/web
RUN \
pip3 install --no-cache-dir -r requirements.txt
