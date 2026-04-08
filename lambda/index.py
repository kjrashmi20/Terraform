import json

def lambda_handler(event, context):
    print("EC2 EVENT DETECTED")
    print(json.dumps(event, indent=2))

    return {
        "statusCode": 200,
        "body": "ok"
    }
