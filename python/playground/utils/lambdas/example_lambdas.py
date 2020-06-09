#%%
import boto3
import json

#%% 
if __name__ == "__main__":
    # create lambda client
    client = boto3.client('lambda')

    # create payload package
    data = {
        "hello" : "world",
    }

    # invoke lambda function
    response = client.invoke(
        FunctionName = "nx-test-function",
        Payload = json.dumps(data)
    )

    # return payload
    json_response = json.loads(response['Payload'].read())
    print(json_response['body'])