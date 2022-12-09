from dotenv import load_dotenv
import os
from json import dumps, loads
from src.config.confluent_consumer import consumer
from src.config.confluent_producer import ProducerMessage
from numpy import random


def main(body, client_id) -> dict:

    #Dump message body
    body = dumps(body)

    # Send frontend request
    ProducerMessage('streamlit-request').run(body)

    consumer.subscribe(['streamlit-response'])

    while True:
        message = consumer.poll(1.0)

        if message is None:
            continue
        elif message.error():
            print("Consumer error: {}".format(message.error()))
            continue
        else:
            print('Received message: {}'.format(message.value().decode('utf-8')))

            data = message.value().decode('utf-8')
            data = loads(data)

            if 'client_id' in message.keys():
                if message['client_id'] == client_id:
                    print('Received message: {}'.format(message.value().decode('utf-8')))

                    consumer.commit()
                    consumer.close()
                    return data
                else:
                    continue
            else:
                continue
