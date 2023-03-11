import json
import boto3

dynamo_client = boto3.client('dynamodb')

def lambda_get_handler(event, context):
    data = dynamo_client.get_item(
        TableName='site_stats',
        Key={
            'stat' : {'S':'view_count'}
        }
    )
    
    view_count = data['Item']['view_count']['N']

    return {
        'statusCode': 200,
        'headers': {
            'Content-Type': 'application/json'
        },
        'body': json.dumps(view_count)
        }