import json
import boto3
import logging

from botocore.exceptions import ClientError


dynamo_client = boto3.client('dynamodb')
logger = logging.getLogger(__name__)

def lambda_put_handler(event, context):
    try:
        update_resp = dynamo_client.update_item(
            TableName='site_stats',
            Key= {
                'stat': {
                    'S': 'view_count'
                },
            },
            ExpressionAttributeValues={':val': {'N': '1'}},
            ReturnValues='UPDATED_NEW',
            UpdateExpression='ADD view_count :val'
        )
    except ClientError as err:
        logger.error(
        "Couldn't update view_count. Here's why: %s: %s",
        err.response['Error']['Code'], err.response['Error']['Message'])
    else:
        return {
            'statusCode': 200,
            'headers': {
                'Content-Type': 'application/json'
            },
            'body': json.dumps(update_resp['Attributes'])
        }
