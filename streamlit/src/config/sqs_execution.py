from dotenv import load_dotenv
import os
from json import dumps, loads
from src.config.confluent_consumer import consumer
from src.config.confluent_producer import ProducerMessage
from numpy import random

consumer.subscribe(['streamlit-response'])

def sqs_main(body) -> dict:

    while True:

        body = dumps(body)
        # Send frontend request
        ProducerMessage('streamlit-request').run(body)

        # Poll for a request
        message = consumer.poll(1.0)
        if message is None:
            continue
        if message.error():
            print("Consumer error: {}".format(message.error()))
            continue

        print('Received message: {}'.format(message.value().decode('utf-8')))

        data = message.value().decode('utf-8')
        data = loads(data)

        consumer.commit()

        return data
