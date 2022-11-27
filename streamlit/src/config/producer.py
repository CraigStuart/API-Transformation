import boto3
import os
bootstrap_sqs = os.getenv("SQS_QUEUE_URL")

# Create SQS client
sqs = boto3.client(bootstrap_sqs)

def send_sqs_message(body):

    for record in body:
        # Send message to SQS queue
        response = sqs.send_message(
            QueueUrl=bootstrap_sqs,
            DelaySeconds=0,
            MessageAttributes={
            },
            MessageBody=(
                record
            )
        )

        print(response['body'])

        return response['body']