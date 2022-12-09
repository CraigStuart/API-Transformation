import os
from dotenv import load_dotenv
from confluent_kafka import Consumer

load_dotenv()

CONSUMER_CONFIG = {
    'bootstrap.servers': os.getenv("KAFKA_QUEUE_URL"),
    'group.id': 'orchestrator-group',
    'auto.offset.reset': 'earliest',
    'enable.auto.commit': False
}

"""The Kafka producer configuration parameters for additional security (`dict`).
"""

consumer = Consumer(CONSUMER_CONFIG)
