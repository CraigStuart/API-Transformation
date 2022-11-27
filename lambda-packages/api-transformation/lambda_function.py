from __future__ import print_function
import json
import re

def lambda_handler(event, context):
    for record in event['Records']:
        
        payload = record["body"]

        payload_updated = re.sub(str(payload["find"]), str(payload["replace"]), payload["body"])

        return {
        
            'statusCode': 200,
            'body': json.dumps(str(payload_updated))
        }

