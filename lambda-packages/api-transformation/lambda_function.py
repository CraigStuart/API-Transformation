from __future__ import print_function
from json import dumps, loads
import re
import os
import os
from dotenv import load_dotenv
import pandas as pd
from confluent_kafka import Consumer
from confluent_kafka import Producer
from json import dumps, loads

load_dotenv()

bootstrap_kafka = os.getenv("KAFKA_QUEUE_URL")

CONSUMER_CONFIG = {
    'bootstrap.servers': os.getenv("KAFKA_QUEUE_URL"),
    'group.id': 'orchestrator-group',
    'auto.offset.reset': 'earliest',
    'enable.auto.commit': False
}

PRODUCER_CONFIG = {
    # Create producer properties
    'bootstrap.servers': os.getenv("KAFKA_QUEUE_URL"),
    # Create safe producer
    'enable.idempotence': True,
    'acks': 'all',
    # 'retries': 2147483647,
    'max.in.flight.requests.per.connection': 5,
    # Create high throughput producer
    'compression.type': 'snappy',
    'linger.ms': 20,
    'batch.size': 32 * 1024
}


class ProducerMessage:

    def __init__(self, topic, message):
        self.topic = topic
        self.message = dumps(message)
        self.producer = Producer(PRODUCER_CONFIG)

    def delivery_report(self, err, msg):
        """ Called once for each message produced to indicate delivery result.
            Triggered by poll() or flush(). """
        if err is not None:
            print('Message delivery failed: {}'.format(err))
        else:
            print('Message delivered to {} [{}]'.format(msg.topic(), msg.partition()))

    def run(self):
        self.producer.poll(0)
        self.producer.produce(self.topic, value=self.message.encode('utf-8'), callback=self.delivery_report)
        self.producer.flush(10)
        print("Message sent: {}".format(self.topic))
        print("=====================================================================")


def lambda_handler():

    consumer = Consumer(CONSUMER_CONFIG)
    consumer.subscribe(['streamlit-response'])

    while True:
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

        #Run transformation on the input
        response_transformed = transformation(data)
        response_transformed = dumps(response_transformed)

        # Send message back to the frontend
        ProducerMessage('streamlit-response', response_transformed).run()

def transformation(body) -> dict:

    body_updated = re.sub(str(body["find"]), str(body["replace"]), body["body"])

    return body_updated


if __name__ == '__main__':
    lambda_handler()
