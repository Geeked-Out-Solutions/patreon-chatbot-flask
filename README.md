# patreon-chatbot-flask
A flask chatbot app using Rasa NLU and Core - in development

Rasa Core Docs - https://core.rasa.ai/tutorial_remote.html
Rasa NLU Docs - https://nlu.rasa.ai/tutorial.html

## Building The Image
1. First clone this repo then cd into that folder and run:
`docker build -t rasa-core .` you can replace rasa-core with whatever tag/name you want for the image.

2. Then once this is done building you can start up the container with:
`docker run -itd -p 5005:5005 rasa-core` replacing rasa-core with the image name from the first step.

Now you can use the following python code to test that it is working replacing the 0.0.0.0 with your docker host ip:
```
import requests
question = 'hey there'
url = 'http://0.0.0.0:5005/conversations/default/parse?q=' + question
r = requests.get(url)
output = r.json()
print(output)
```

If working you should get something like the following back:
```
{'next_action': 'utter_greet',
 'tracker': {'latest_message': {'entities': [],
   'intent': {'confidence': 0.6938407400733462, 'name': 'greet'},
   'intent_ranking': [{'confidence': 0.6938407400733462, 'name': 'greet'},
    {'confidence': 0.1827009639484415, 'name': 'goodbye'},
    {'confidence': 0.08132020471151456, 'name': 'thankyou'},
    {'confidence': 0.042138091266697805, 'name': 'help'}],
   'text': 'hey there'},
  'sender_id': 'default',
  'slots': {}}}
  ```
