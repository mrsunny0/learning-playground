#%%
import boto3
import os
bucket_name = 'nx-playground'

#%% Viewing buckets
s3 = boto3.resource('s3')
buckets = s3.buckets.all()

# or 
buckets = s3.buckets.limit(10)

# getting a specific bucket
bucket = s3.Bucket(bucket_name)

#%% Filtering through buckets
# viewing all files in bucket
for f in bucket.objects.all():
    print(f)

# filtering through bucket
# using resource
prefix = "file"
for obj in bucket.objects.filter(Prefix=prefix):
    print(obj)

# using client, note that Prefix can be a subfolder name
# returns dictionary of key/content and metadata
s3_client = boto3.client('s3')
filter_result = s3_client.list_objects(Bucket=bucket_name, Prefix=prefix)
contents = filter_result['Contents'] 
for c in contents:
    print(c['Key'])

#%% Downloading
# using meta client
s3.meta.client.download_file(bucket_name, 'helloworld.txt', 'tmp-meta.txt')

# using client directly
s3_client.download_file(bucket_name, 'helloworld.txt', 'tmp-client.txt')

# using download_file from Bucket
bucket.download_file("helloworld.txt", "tmp-Bucket.txt")

#%% Uploading
# create an s3 object via resource and put
# or use client meta to upload_file
contents = b'New file upload - from resource'
new_object = s3.Object(bucket_name, "tmp/file_upload_resource.txt")
new_object.put(Body=contents)

s3.meta.client.upload_file(Filename=os.path.join(os.getcwd(), "main.py"),
    Bucket=bucket_name,
    Key='tmp/file_upload_resource-upload.txt')

# create an s3 object using client
# either upload_file or put_object
# upload_file will handle multipart uploads, put_object will send an entire body
# upload_file takes from an existing file on the OS
contents = b'New file upload - from client'
s3_client.put_object(Body=contents, 
    Bucket=bucket_name, 
    Key='tmp/file_upload_client.txt')

s3_client.upload_file(Filename=os.path.join(os.getcwd(), "main.py"),
    Bucket=bucket_name,
    Key='tmp/file_upload_client-upload.txt')
