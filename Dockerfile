FROM ubuntu:latest
MAINTAINER Brian Hopkins "brianhh1230@gmail.com"
RUN \
apt-get update -y && \
apt-get install -y python3-pip python3-dev build-essential git pandoc
COPY . /app
WORKDIR /app/web
RUN \
pip3 install pypandoc && \
pip3 install --no-cache-dir -r requirements.txt && \
git clone https://github.com/RasaHQ/rasa_core.git && \
cd rasa_core && \
pip3 install --no-cache-dir -r requirements.txt && \
python3 setup.py install && \
git clone https://github.com/Geeked-Out-Solutions/patreon-rasa-model.git
WORKDIR /app/web/patreon-rasa-model
RUN \ 
python3 -m spacy download en && \
ls -lah
python3 -m rasa_nlu.train -c nlu_model_config.json --fixed_model_name current && \
python3 -m rasa_core.train -s data/stories.md -d domain.yml -o models/dialogue && \
python3 -m rasa_core.server -d models/dialogue -u models/nlu/current -o out.log

