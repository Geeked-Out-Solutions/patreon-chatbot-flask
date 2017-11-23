#!/bin/bash
python3 -m spacy download en
python3 -m rasa_core.train -s data/stories.md -d domain.yml -o models/dialogue
python3 -m rasa_core.server -d data/models/dialogue -u models/nlu/current
