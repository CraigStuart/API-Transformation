import os
from dotenv import load_dotenv
import pandas as pd
from confluent_kafka import Producer
from json import dumps, loads
from src.config.client_config import client_config

load_dotenv()


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
    'batch.size': 32 * 1024,
    'client.id': client_config['client.id']
}

"""The Kafka producer configuration parameters for additional security (`dict`).
"""

class ProducerMessage:

    def __init__(self, topic):
        self.topic = topic
        self.producer = Producer(PRODUCER_CONFIG)

    def delivery_report(self, err, msg):
        """ Called once for each message produced to indicate delivery result.
            Triggered by poll() or flush(). """
        if err is not None:
            print('Message delivery failed: {}'.format(err))
        else:
            print('Message delivered to {} [{}]'.format(msg.topic(), msg.partition()))

    def run(self, message):
        message = dumps(message)
        self.producer.poll(0)
        self.producer.produce(self.topic, value=message.encode('utf-8'), callback=self.delivery_report)
        self.producer.flush(10)
        print("Message sent: {}".format(self.topic))
        print("=====================================================================")
