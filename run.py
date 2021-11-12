import os
import json


access_token = os.environ["GITEE_ACCESS_TOKEN"]
nodes_str = os.environ["NODES"]

for k,v in json.loads(nodes_str).items:
    print(k,v)


