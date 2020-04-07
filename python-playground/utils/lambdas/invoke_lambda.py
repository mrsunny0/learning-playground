#%%
import boto3
import json

#%%
client = boto3.client('lambda')

#%%

data = {
    "hello" : "world",
    "whtaoi" : "eofi",
}

response = client.invoke(
    FunctionName = "nx-test-function",
    Payload = json.dumps(data)
)

json_response = json.loads(response['Payload'].read())
print(json_response['body'])

#%%
