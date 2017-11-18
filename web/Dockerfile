FROM ubuntu:latest
MAINTAINER Brian Hopkins "brianhh1230@gmail.com"
RUN apt-get update -y
RUN apt-get install -y python3-pip python3-dev build-essential
COPY . /app
WORKDIR /app
RUN ls -lah
RUN pip3 install -r requirements.txt
ENTRYPOINT ["python"]
CMD ["app.py"]
