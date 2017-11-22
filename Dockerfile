FROM ubuntu:latest
MAINTAINER Brian Hopkins "brianhh1230@gmail.com"
ENV RASA_MODEL=/app/data
RUN \
apt-get update -y && \
apt-get install -y python3-pip python3-dev build-essential git pandoc
COPY . /app
WORKDIR /app/data
RUN \
pip3 install pypandoc && \
pip3 install --no-cache-dir -r requirements.txt && \
git clone https://github.com/RasaHQ/rasa_core.git && \
cd rasa_core && \
pip3 install --no-cache-dir -r requirements.txt && \
python3 setup.py install
WORKDIR /app/data
COPY . ${RASA_MODEL}
RUN \ 
python3 -m spacy download en && \
python3 -m rasa_nlu.train -c ${RASA_MODEL}/nlu_model_config.json --fixed_model_name current && \
python3 -m rasa_core.train -s ${RASA_MODEL}/data/stories.md -d ${RASA_MODEL}/domain.yml -o ${RASA_MODEL}/models/dialogue
ENTRYPOINT ["python3 -m rasa_core.server -d ${RASA_MODEL}/models/dialogue -u ${RASA_MODEL}/models/nlu/current -o out.log"]

