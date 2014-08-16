#Python script to backup google documents

import gdata.docs.data
import gdata.docs.client

client = gdata.docs.client.DocsClient(source='yourCo-yourAppName-v1')
client.ssl = True  # Force all API requests through HTTPS
client.http_client.debug = False  # Set to True for debugging HTTP requests

feed = client.GetDocList(uri='/feeds/user@yourdomain.com/private/full')
PrintFeed(feed)  # PrintFeed() defined below