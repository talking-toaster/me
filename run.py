import os
import json


access_token = os.environ["GITEE_ACCESS_TOKEN"]
nodes_str = os.environ["NODES"]

nodes = json.loads(nodes_str)

for k,v in nodes.items():
    print(k,v)

