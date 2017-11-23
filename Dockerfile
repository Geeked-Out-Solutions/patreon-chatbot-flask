FROM ubuntu:latest
MAINTAINER Brian Hopkins "brianhh1230@gmail.com"
ENV RASA_MODEL=/app
RUN \
apt-get update -y && \
apt-get install -y python3-pip python3-dev build-essential git pandoc
COPY . /app
WORKDIR /app
RUN \
chmod +x entrypoint.sh && \
pip3 install pypandoc && \
ls -lah && \
pwd && \
pip3 install --no-cache-dir -r requirements.txt && \
git clone https://github.com/RasaHQ/rasa_core.git && \
cd rasa_core && \
pip3 install --no-cache-dir -r requirements.txt && \
python3 setup.py install
WORKDIR /app
COPY . ${RASA_MODEL}
RUN \ 
python3 -m spacy download en && \
python3 -m rasa_nlu.train -c /app/nlu_model_config.json --fixed_model_name current
ENTRYPOINT ["./entrypoint.sh"]
